/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A view controller displaying a grid of assets.
 */

@import UIKit;
@import Photos;

@class BFTask;

@interface GalleryCollectionViewController : UICollectionViewController

@property (nonatomic, strong) PHFetchResult *assetsFetchResults;
@property (nonatomic, strong) PHAssetCollection *assetCollection;
@property (nonatomic, copy) void (^selectionBlock)(GalleryCollectionViewController *galleryCollectionVC);
@property (nonatomic, readonly) NSMutableSet *selectedAssets;

+ (instancetype)galleryCollectionPickerVC;
- (BFTask *)getSelectedAssetData;

@end
