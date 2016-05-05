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

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>

#import "SDWebImageDownloader.h"

const NSInteger PAGE_LIMIT = 20;

@interface ChannelStreamDataSource ()

@property (nonatomic, strong) UICollectionView *collectionView;
//
//@property (nonatomic, strong) NSMutableArray *posts;
//@property (nonatomic, strong) NSMutableArray *allPhotos;

@property (nonatomic, strong) NSMutableArray *photos;

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

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = [NSMutableArray new];
    }
    return _photos;
}

- (void)setChannel:(Channel *)channel {
    _channel = channel;
    [self setupListeners];
}

- (void)setupListeners {
    FQuery *initialQuery = [[self.channel.ref childByAppendingPath:@"photos"] queryLimitedToLast:PAGE_LIMIT];
    [self loadPageWithQuery:initialQuery removeObserverWhenLimitReached:NO];
}

- (void)loadNextPage {
    if (self.isLoading || self.photos.count == 0) {
        return;
    }
    
    Photo *lastPhoto = self.photos.lastObject;
    NSString *lastKey = lastPhoto.objectId;
    FQuery *query = [[[[self.channel.ref childByAppendingPath:@"photos"] queryOrderedByKey] queryEndingAtValue:lastKey] queryLimitedToLast:PAGE_LIMIT];
    [self loadPageWithQuery:query removeObserverWhenLimitReached:YES];
}

- (void)loadPageWithQuery:(FQuery *)query removeObserverWhenLimitReached:(BOOL)shouldRemove {
    self.isLoading = YES;
    __block NSInteger count = 0;
    [query observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self handleNewPhotoWithSnapshot:snapshot];
        
        count++;
        if (count >= PAGE_LIMIT - 1) {
            self.shouldFlipLoadingFlagOnNextReload = YES;
            
            if (shouldRemove) {
                [query removeAllObservers];
            }
        }
    }];
}

- (void)handleNewPhotoWithSnapshot:(FDataSnapshot *)snapshot {
    [[Photo photoFromRef:snapshot.ref inChannel:self.channel] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        // Make sure the same photo is never added twice
        Photo *photo = task.result;
        NSUInteger existingIndex = [self.photos indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Photo *testPhoto = (Photo *)obj;
            return [testPhoto.objectId isEqualToString:photo.objectId];
        }];
        
        if (existingIndex != NSNotFound) {
            return nil;
        }
        
        // Find the right place to insert it chronologically
        NSInteger index = [self.photos indexOfObject:photo inSortedRange:NSMakeRange(0, self.photos.count) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
            return [p2.timestamp compare:p1.timestamp];
        }];
        
        // Warm the cache with the thumbnail
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:photo.thumbnailUrl options:SDWebImageDownloaderLowPriority progress:nil completed:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photos insertObject:photo atIndex:index];
            [self debouncedReload];
        });

        return nil;
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
    if (indexPath.row < self.photos.count) {
        return self.photos[indexPath.item];
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.photos.count == 0) {
        return 2; // For loading views
    } else {
        return  self.photos.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier
                                                             forIndexPath:indexPath];
    
    if (self.populateCell && self.photos.count > indexPath.row) {
        self.populateCell(cell, [self photoAtIndexPath:indexPath]);
    }
    
    return cell;
}

@end
