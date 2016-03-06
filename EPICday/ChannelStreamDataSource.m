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
#import "PostCollectionViewHeader.h"

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>

@interface ChannelStreamDataSource ()

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) NSMutableArray *allPhotos;

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

+ (instancetype)dataSourceWithChannel:(Channel *)channel
                     inCollectionView:(UICollectionView *)collectionView
                        withCellClass:(Class)cellClass
                   andReuseIdentifier:(NSString *)reuseIdentifier {
    ChannelStreamDataSource *dataSource = [self new];
    dataSource.channel = channel;
    dataSource.collectionView = collectionView;
    collectionView.dataSource = dataSource;
    dataSource.cellClass = cellClass;
    dataSource.reuseIdentifier = reuseIdentifier;
    [collectionView registerClass:cellClass
       forCellWithReuseIdentifier:reuseIdentifier];
    [collectionView registerClass:[PostCollectionViewHeader class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:[PostCollectionViewHeader defaultIdentifier]];
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
    BFTaskCompletionSource *initalLoadTaskSource = [BFTaskCompletionSource taskCompletionSource];
    [[self.channel.ref childByAppendingPath:@"posts"] observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *postsDict = snapshot.value;
        NSMutableArray *tasks = @[].mutableCopy;
        [postsDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            Firebase *postRef = [[[self.channel.ref root] childByAppendingPath:@"posts"] childByAppendingPath:key];
            BFTask *task = [self insertPostFromRefAndSetupListeners:postRef updateCollectionView:NO];
            [tasks addObject:task];
        }];
        [[BFTask taskForCompletionOfAllTasks:tasks] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
            [initalLoadTaskSource trySetResult:task.result];
            return nil;
        }];
    }];
    [initalLoadTaskSource.task continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        [self.collectionView reloadData];
        [[self.channel.ref childByAppendingPath:@"posts"] observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
            Firebase *postRef = [[[self.channel.ref root] childByAppendingPath:@"posts"] childByAppendingPath:snapshot.key];
            [self insertPostFromRefAndSetupListeners:postRef updateCollectionView:YES];
        }];
        return nil;
    }];
//    [[self.channel.ref childByAppendingPath:@"posts"] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
//        Firebase *postRef = [[[self.channel.ref root] childByAppendingPath:@"posts"] childByAppendingPath:snapshot.key];
//        [[Post postFromRef:postRef inChannel:self.channel] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
//            Post *post = task.result;
//            NSDictionary *postDict = @{@"post": post, @"photos": @[].mutableCopy};
//            NSInteger index = [self.posts indexOfObject:postDict inSortedRange:NSMakeRange(0, self.posts.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(NSDictionary *p1Dict, NSDictionary *p2Dict) {
//                Post *p1 = p1Dict[@"post"];
//                Post *p2 = p2Dict[@"post"];
//                return [p2.timestamp compare:p1.timestamp];
//            }];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.posts insertObject:postDict atIndex:index];
////                [self.collectionView reloadData];
////                [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:index]];
//            });
//            [self setupListenersForPostDict:postDict];
//            return nil;
//        }];
//    }];
}

- (BFTask *)insertPostFromRefAndSetupListeners:(Firebase *)postRef updateCollectionView:(BOOL)updateCollectionView {
    return [[Post postFromRef:postRef inChannel:self.channel] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        Post *post = task.result;
        NSDictionary *postDict = @{@"post": post, @"photos": @[].mutableCopy};
        NSInteger index = [self.posts indexOfObject:postDict inSortedRange:NSMakeRange(0, self.posts.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(NSDictionary *p1Dict, NSDictionary *p2Dict) {
            Post *p1 = p1Dict[@"post"];
            Post *p2 = p2Dict[@"post"];
            return [p2.timestamp compare:p1.timestamp];
        }];
        [self.posts insertObject:postDict atIndex:index];
        return [self setupListenersForPostDict:postDict updateCollectionView:updateCollectionView];
//        return nil;
    }];
}

- (BFTask *)setupListenersForPostDict:(NSDictionary *)postDict updateCollectionView:(BOOL)updateCollectionView {
    Post *post = postDict[@"post"];
    BFTaskCompletionSource *initalLoadTaskSource = [BFTaskCompletionSource taskCompletionSource];
    [[post.ref childByAppendingPath:@"photos"] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if ([snapshot.value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *photosDict = snapshot.value;
            NSMutableArray *tasks = @[].mutableCopy;
            [photosDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                Firebase *photoRef = [[[post.ref root] childByAppendingPath:@"photos"] childByAppendingPath:key];
                BFTask *task = [self insertPhotoFromRefAndSetupListeners:photoRef inPost:post updateCollectionView:updateCollectionView];
                [tasks addObject:task];
            }];
            [[BFTask taskForCompletionOfAllTasks:tasks] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
                [initalLoadTaskSource trySetResult:task.result];
                return nil;
            }];
        } else {
            [initalLoadTaskSource trySetResult:@YES];
        }
    }];
    return [initalLoadTaskSource.task continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        [[post.ref childByAppendingPath:@"photos"] observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
            Firebase *photoRef = [[[post.ref root] childByAppendingPath:@"photos"] childByAppendingPath:snapshot.key];
            [self insertPhotoFromRefAndSetupListeners:photoRef inPost:post updateCollectionView:YES];
        }];
        return nil;
    }];
}

- (BFTask *)insertPhotoFromRefAndSetupListeners:(Firebase *)photoRef inPost:(Post *)post updateCollectionView:(BOOL)updateCollectionView {
    return [[Photo photoFromRef:photoRef inPost:post] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        BFTaskCompletionSource *taskSource = [BFTaskCompletionSource taskCompletionSource];
        Photo *photo = task.result;
        NSInteger allPhotosIndex = [self.allPhotos indexOfObject:photo inSortedRange:NSMakeRange(0, self.allPhotos.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
            return [p2.timestamp compare:p1.timestamp];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (updateCollectionView) {
                [self.collectionView performBatchUpdates:^{
                    [self.allPhotos insertObject:photo atIndex:allPhotosIndex];
                    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:allPhotosIndex inSection:0]]];
                } completion:^(BOOL finished) {
                    [taskSource trySetResult:@YES];
                }];
            } else {
                
                [self.allPhotos insertObject:photo atIndex:allPhotosIndex];
                [taskSource trySetResult:@YES];
            }
        });
        return taskSource.task;
    }];
}

//- (void)setupListenersForPostDict:(NSDictionary *)postDict {
//    Post *post = postDict[@"post"];
//    [[post.ref childByAppendingPath:@"photos"] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
//        Firebase *photoRef = [[[post.ref root] childByAppendingPath:@"photos"] childByAppendingPath:snapshot.key];
//        [[Photo photoFromRef:photoRef inPost:post] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
//            Photo *photo = task.result;
//            NSMutableArray *photosArray = postDict[@"photos"];
//            NSInteger index = [photosArray indexOfObject:photo inSortedRange:NSMakeRange(0, photosArray.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
//                return [p2.timestamp compare:p1.timestamp];
//            }];
//            NSInteger allPhotosIndex = [self.allPhotos indexOfObject:photo inSortedRange:NSMakeRange(0, self.allPhotos.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
//                return [p2.timestamp compare:p1.timestamp];
//            }];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [photosArray insertObject:photo atIndex:index];
//                [self.allPhotos insertObject:photo atIndex:allPhotosIndex];
//                [self.collectionView performBatchUpdates:^{
//                    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:allPhotosIndex inSection:0]]];
//                } completion:nil];
////                NSInteger sectionIndex = [self.posts indexOfObject:postDict];
////                [self.collectionView reloadData];
////                [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:sectionIndex]]];
//            });
//            return nil;
//        }];
//    }];
//}

//- (Post *)postForSection:(NSInteger)section {
//    return self.posts[section][@"post"];
//}
//
//- (Photo *)photoAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray *photos = self.posts[indexPath.section][@"photos"];
//    return photos[indexPath.item];
//}

- (Photo *)photoAtIndexPath:(NSIndexPath *)indexPath {
    return self.allPhotos[indexPath.item];
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return self.posts.count;
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSArray *photos = self.posts[section][@"photos"];
//    return photos.count;
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

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        PostCollectionViewHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[PostCollectionViewHeader defaultIdentifier] forIndexPath:indexPath];
//        header.post = [self postForSection:indexPath.section];
//        return header;
//    }
//    return nil;
//}

@end
