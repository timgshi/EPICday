//
//  ChannelStreamDataSource.m
//  EPICday
//
//  Created by Tim on 2/4/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "ChannelStreamDataSource.h"

#import "Channel.h"
#import "Photo.h"
#import "Post.h"

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>

const NSInteger PAGE_LIMIT = 50;

@interface ChannelStreamDataSource ()

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) NSMutableArray *allPhotos;

@property (nonatomic, strong) NSTimer *debounceTimer;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL shouldFlipLoadingFlagOnNextReload;

@end

@implementation ChannelStreamDataSource

+ (instancetype)dataSourceWithChannel:(Channel *)channel
                     inCollectionView:(UICollectionView *)collectionView
                   andReuseIdentifier:(NSString *)reuseIdentifier {
    ChannelStreamDataSource *dataSource = [self new];
    dataSource.channel = channel;
    dataSource.collectionView = collectionView;
    collectionView.dataSource = dataSource;
    dataSource.reuseIdentifier = reuseIdentifier;
    return dataSource;
}

- (NSMutableArray *)posts {
    if (!_posts) {
        _posts = @[].mutableCopy;
    }
    return _posts;
}

- (NSMutableArray *)allPhotos {
    if (!_allPhotos) {
        _allPhotos = @[].mutableCopy;
    }
    return _allPhotos;
}

- (void)setChannel:(Channel *)channel {
    _channel = channel;
    [self setupListeners];
}

- (void)setupListeners {
    FQuery *initialQuery = [[self.channel.ref childByAppendingPath:@"posts"] queryLimitedToLast:PAGE_LIMIT];
    [self loadPageWithQuery:initialQuery removeObserverWhenLimitReached:NO];
}

- (void)loadNextPage {
    if (self.isLoading || self.posts.count == 0) {
        return;
    }
    
    NSLog(@"Loading next page");
    
    Post *lastPost = self.posts.lastObject[@"post"];
    NSString *lastKey = lastPost.objectId;
    FQuery *query = [[[[self.channel.ref childByAppendingPath:@"posts"] queryOrderedByKey] queryEndingAtValue:lastKey] queryLimitedToLast:PAGE_LIMIT];
    [self loadPageWithQuery:query removeObserverWhenLimitReached:YES];
}

- (void)loadPageWithQuery:(FQuery *)query removeObserverWhenLimitReached:(BOOL)shouldRemove {
    self.isLoading = YES;
    __block NSInteger count = 0;
    [query observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self handleNewPostWithSnapshot:snapshot];
        
        count++;
        if (count >= PAGE_LIMIT - 1) {
            self.shouldFlipLoadingFlagOnNextReload = YES;
            
            if (shouldRemove) {
                [query removeAllObservers];
            }
        }
    }];
}

- (void)handleNewPostWithSnapshot:(FDataSnapshot *)snapshot {
    Firebase *postRef = [[[self.channel.ref root] childByAppendingPath:@"posts"] childByAppendingPath:snapshot.key];
    [[Post postFromRef:postRef inChannel:self.channel] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        Post *post = task.result;
        NSDictionary *postDict = @{@"post": post, @"photos": @[].mutableCopy};
        NSString *objectID = post.objectId;
        NSUInteger existingIndex = [self.posts indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *testPostDict = (NSDictionary *)obj;
            Post *testPost = testPostDict[@"post"];
            return [testPost.objectId isEqualToString:objectID];
        }];
        
        if (existingIndex != NSNotFound) {
            return nil;
        }
        
        NSInteger index = [self.posts indexOfObject:postDict inSortedRange:NSMakeRange(0, self.posts.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(NSDictionary *p1Dict, NSDictionary *p2Dict) {
            Post *p1 = p1Dict[@"post"];
            Post *p2 = p2Dict[@"post"];
            return [p2.timestamp compare:p1.timestamp];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.posts insertObject:postDict atIndex:index];
        });
        [self setupListenersForPostDict:postDict];
        return nil;
    }];
}

- (void)setupListenersForPostDict:(NSDictionary *)postDict {
    Post *post = postDict[@"post"];
    [[post.ref childByAppendingPath:@"photos"] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        Firebase *photoRef = [[[post.ref root] childByAppendingPath:@"photos"] childByAppendingPath:snapshot.key];
        [[Photo photoFromRef:photoRef inPost:post] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
            Photo *photo = task.result;
            NSMutableArray *photosArray = postDict[@"photos"];
            NSInteger index = [photosArray indexOfObject:photo inSortedRange:NSMakeRange(0, photosArray.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
                return [p2.timestamp compare:p1.timestamp];
            }];
            NSInteger allPhotosIndex = [self.allPhotos indexOfObject:photo inSortedRange:NSMakeRange(0, self.allPhotos.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
                return [p2.timestamp compare:p1.timestamp];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [photosArray insertObject:photo atIndex:index];
                [self.allPhotos insertObject:photo atIndex:allPhotosIndex];
                [self debouncedReload];
            });
            return nil;
        }];
    }];
}

- (void)debouncedReload {
    [self.debounceTimer invalidate];
    self.debounceTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadData) userInfo:nil repeats:NO];
}

- (void)reloadData {
    [self.collectionView reloadData];
    if (self.shouldFlipLoadingFlagOnNextReload) {
        self.isLoading = NO;
        self.shouldFlipLoadingFlagOnNextReload = NO;
    }
}

- (Photo *)photoAtIndexPath:(NSIndexPath *)indexPath {
    return self.allPhotos[indexPath.item];
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier
                                                             forIndexPath:indexPath];
    
    if (self.populateCell) {
        self.populateCell(cell, [self photoAtIndexPath:indexPath]);
    }
    
    return cell;
}

@end
