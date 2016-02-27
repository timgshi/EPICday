/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A view controller displaying a grid of assets.
 */

#import "GalleryCollectionViewController.h"

#import "GalleryCollectionViewCell.h"
#import "NSIndexSet+Convenience.h"
#import "UICollectionView+Convenience.h"
#import "UIColor+EPIC.h"

@import PhotosUI;

@interface GalleryCollectionViewController () <PHPhotoLibraryChangeObserver, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property CGRect previousPreheatRect;
@property (nonatomic, strong) NSMutableSet *selectedAssets;

@end


@implementation GalleryCollectionViewController

+ (instancetype)galleryCollectionPickerVC {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    GalleryCollectionViewController *galleryVC = [[self alloc] initWithCollectionViewLayout:flowLayout];
    return galleryVC;
}

- (NSMutableSet *)selectedAssets {
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableSet set];
    }
    return _selectedAssets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor epicDarkGrayColor];
    self.collectionView.allowsMultipleSelection = YES;
    
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    self.assetsFetchResults = allPhotos;
    
    self.imageManager = [[PHCachingImageManager alloc] init];
    [self resetCachedAssets];
    [self.collectionView registerClass:[GalleryCollectionViewCell class]
            forCellWithReuseIdentifier:[GalleryCollectionViewCell defaultIdentifier]];
    
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Begin caching assets in and around collection view's visible rect.
    [self updateCachedAssets];
}

#pragma mark - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    // Check if there are changes to the assets we are showing.
    PHFetchResultChangeDetails *collectionChanges = [changeInstance changeDetailsForFetchResult:self.assetsFetchResults];
    if (collectionChanges == nil) {
        return;
    }
    
    /*
        Change notifications may be made on a background queue. Re-dispatch to the
        main queue before acting on the change as we'll be updating the UI.
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        // Get the new fetch result.
        self.assetsFetchResults = [collectionChanges fetchResultAfterChanges];
        
        UICollectionView *collectionView = self.collectionView;
        
        if (![collectionChanges hasIncrementalChanges] || [collectionChanges hasMoves]) {
            // Reload the collection view if the incremental diffs are not available
            [collectionView reloadData];
            
        } else {
            /*
                Tell the collection view to animate insertions and deletions if we
                have incremental diffs.
             */
            [collectionView performBatchUpdates:^{
                NSIndexSet *removedIndexes = [collectionChanges removedIndexes];
                if ([removedIndexes count] > 0) {
                    [collectionView deleteItemsAtIndexPaths:[removedIndexes aapl_indexPathsFromIndexesWithSection:0]];
                }
                
                NSIndexSet *insertedIndexes = [collectionChanges insertedIndexes];
                if ([insertedIndexes count] > 0) {
                    [collectionView insertItemsAtIndexPaths:[insertedIndexes aapl_indexPathsFromIndexesWithSection:0]];
                }
                
                NSIndexSet *changedIndexes = [collectionChanges changedIndexes];
                if ([changedIndexes count] > 0) {
                    [collectionView reloadItemsAtIndexPaths:[changedIndexes aapl_indexPathsFromIndexesWithSection:0]];
                }
            } completion:NULL];
        }
        
        [self resetCachedAssets];
    });
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsFetchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = self.assetsFetchResults[indexPath.item];

    // Dequeue an AAPLGridViewCell.
    GalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GalleryCollectionViewCell defaultIdentifier]
                                                                                forIndexPath:indexPath];
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    // Request an image for the asset from the PHCachingImageManager.
    [self.imageManager requestImageForAsset:asset
								 targetSize:CGSizeMake(CGRectGetWidth(self.collectionView.frame) / 2, CGRectGetWidth(self.collectionView.frame) / 2)
								contentMode:PHImageContentModeAspectFill
									options:nil
							  resultHandler:^(UIImage *result, NSDictionary *info) {
        // Set the cell's thumbnail image if it's still showing the same asset.
        if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
            cell.thumbnailImageView.image = result;
        }
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    [self.selectedAssets addObject:asset];
    if (self.selectionBlock) {
        self.selectionBlock(self);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    [self.selectedAssets removeObject:asset];
    if (self.selectionBlock) {
        self.selectionBlock(self);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    CGFloat width = (CGRectGetWidth(self.collectionView.frame) / 2) - 20;
    CGFloat ratio = width / asset.pixelWidth;
    CGFloat height = asset.pixelHeight * ratio;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Update cached assets for the new visible area.
    [self updateCachedAssets];
}

#pragma mark - Asset Caching

- (void)resetCachedAssets {
    [self.imageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets {
    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect.
    CGRect preheatRect = self.collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    /*
        Check if the collection view is showing an area that is significantly
        different to the last preheated area.
     */
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(self.collectionView.bounds) / 3.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            NSArray *indexPaths = [self.collectionView aapl_indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        } addedHandler:^(CGRect addedRect) {
            NSArray *indexPaths = [self.collectionView aapl_indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        
        // Update the assets the PHCachingImageManager is caching.
        [self.imageManager startCachingImagesForAssets:assetsToStartCaching
											targetSize:CGSizeMake(CGRectGetWidth(self.collectionView.frame) / 2, CGRectGetWidth(self.collectionView.frame) / 2)
										   contentMode:PHImageContentModeAspectFill
											   options:nil];
        [self.imageManager stopCachingImagesForAssets:assetsToStopCaching
										   targetSize:CGSizeMake(CGRectGetWidth(self.collectionView.frame) / 2, CGRectGetWidth(self.collectionView.frame) / 2)
										  contentMode:PHImageContentModeAspectFill
											  options:nil];

        // Store the preheat rect to compare against in the future.
        self.previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler {
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths {
    if (indexPaths.count == 0) { return nil; }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        PHAsset *asset = self.assetsFetchResults[indexPath.item];
        [assets addObject:asset];
    }
    
    return assets;
}

@end


