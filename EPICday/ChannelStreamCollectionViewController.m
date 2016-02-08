//
//  ChannelStreamCollectionViewController.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "ChannelStreamCollectionViewController.h"

#import "ChannelStreamViewController.h"

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SDWebImage/SDWebImageManager.h>

#import "PhotoCollectionViewCell.h"
#import "Post.h"
#import "PostCollectionViewHeader.h"
#import "Photo.h"
#import "UIColor+EPIC.h"

@import Photos;

#import "ChannelStreamDataSource.h"

@interface ChannelStreamCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) Channel *channel;
@property (nonatomic, strong) ChannelStreamDataSource *dataSource;

@end

@implementation ChannelStreamCollectionViewController

+ (instancetype)streamCollectionVCForChannel:(Channel *)channel {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    ChannelStreamCollectionViewController *streamVC = [[self alloc] initWithCollectionViewLayout:flowLayout];
    streamVC.channel = channel;
    return streamVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor epicDarkGrayColor];
    self.collectionView.backgroundColor = [UIColor epicDarkGrayColor];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.contentInset = UIEdgeInsetsMake(55, 0, 90, 0);
    
//    [PhotoCollectionViewCell registerWithCollectionView:self.collectionView];
//    [PostCollectionViewHeader registerWithCollectionView:self.collectionView];
//    
//    [[NSNotificationCenter defaultCenter] addObserverForName:EPICChannelDidUpdatePostsNotification
//                                                      object:nil
//                                                       queue:[NSOperationQueue mainQueue]
//                                                  usingBlock:^(NSNotification * _Nonnull note) {
//                                                      [self debounce:@selector(reloadData) target:self.collectionView delay:1.0];
//    }];
//    [[NSNotificationCenter defaultCenter] addObserverForName:EPICPostDidUpdatePhotosNotification
//                                                      object:nil
//                                                       queue:[NSOperationQueue mainQueue]
//                                                  usingBlock:^(NSNotification * _Nonnull note) {
//                                                      [self debounce:@selector(reloadData) target:self.collectionView delay:1.0];
//                                                  }];
    
    self.dataSource = [ChannelStreamDataSource dataSourceWithChannel:self.channel
                                                    inCollectionView:self.collectionView
                                                       withCellClass:[PhotoCollectionViewCell class]
                                                  andReuseIdentifier:[PhotoCollectionViewCell defaultIdentifier]];
    __weak typeof(self) weakSelf = self;
    self.dataSource.populateCell = ^(UICollectionViewCell *cell, Photo *photo) {
        PhotoCollectionViewCell *photoCell = (PhotoCollectionViewCell *)cell;
        photoCell.photo = photo;
        photoCell.cellDidTapBlock = ^(PhotoCollectionViewCell *blockCell) {
            NSDictionary *userInfo = @{EPICShowChannelStreamNotificationViewTextKey: @"Long press to save photo"};
            [[NSNotificationCenter defaultCenter] postNotificationName:EPICShowFullScreenImageFromCellNotification
                                                                object:blockCell
                                                              userInfo:userInfo];
        };
        photoCell.cellDidLongPressBlock = ^(PhotoCollectionViewCell *blockCell) {
            __strong typeof(self) strongSelf = weakSelf;
            NSDictionary *userInfo = @{EPICShowChannelStreamNotificationViewTextKey: @"Photo saved!"};
            [[NSNotificationCenter defaultCenter] postNotificationName:EPICShowChannelStreamNotificationViewNotification
                                                                object:blockCell.photo
                                                              userInfo:userInfo];
            [strongSelf savePhotoToLibrary:blockCell.photo];
        };
    };
}

- (void)debounce:(SEL)action target:(id)target delay:(NSTimeInterval)delay {
    __weak typeof(target) weakTarget = target;
    [NSObject cancelPreviousPerformRequestsWithTarget:weakTarget selector:action object:nil];
    [weakTarget performSelector:action withObject:nil afterDelay:delay];
}

- (void)savePhotoToLibrary:(Photo *)photo {
    [[SDWebImageManager sharedManager] downloadImageWithURL:photo.imageUrl options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
            if ( status == PHAuthorizationStatusAuthorized ) {
                // To preserve the metadata, we create an asset from the JPEG NSData representation.
                // Note that creating an asset from a UIImage discards the metadata.
                // In iOS 9, we can use -[PHAssetCreationRequest addResourceWithType:data:options].
                // In iOS 8, we save the image to a temporary file and use +[PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:].
                if ( [PHAssetCreationRequest class] ) {
                    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                        [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
                    } completionHandler:^( BOOL success, NSError *error ) {
                        if ( ! success ) {
                            NSLog( @"Error occurred while saving image to photo library: %@", error );
                        }
                    }];
                }
                else {
                    NSString *temporaryFileName = [NSProcessInfo processInfo].globallyUniqueString;
                    NSString *temporaryFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[temporaryFileName stringByAppendingPathExtension:@"jpg"]];
                    NSURL *temporaryFileURL = [NSURL fileURLWithPath:temporaryFilePath];
                    
                    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                        NSError *error = nil;
                        [imageData writeToURL:temporaryFileURL options:NSDataWritingAtomic error:&error];
                        if ( error ) {
                            NSLog( @"Error occured while writing image data to a temporary file: %@", error );
                        }
                        else {
                            [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:temporaryFileURL];
                        }
                    } completionHandler:^( BOOL success, NSError *error ) {
                        if ( ! success ) {
                            NSLog( @"Error occurred while saving image to photo library: %@", error );
                        }
                        
                        // Delete the temporary file.
                        [[NSFileManager defaultManager] removeItemAtURL:temporaryFileURL error:nil];
                    }];
                }
            }
        }];

    }];
}

#pragma mark <UICollectionViewDataSource>

- (Post *)postForSection:(NSInteger)section {
    return self.channel.posts[section];
}

- (Photo *)photoAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = self.channel.posts[indexPath.section];
    return post.photos[indexPath.item];
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return self.channel.posts.count;
//}
//
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [self postForSection:section].photos.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PhotoCollectionViewCell defaultIdentifier]
//                                                                              forIndexPath:indexPath];
//    cell.photo = [self photoAtIndexPath:indexPath];
//    return cell;
//}
//


#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    Photo *photo = [self photoAtIndexPath:indexPath];
    Photo *photo = [self.dataSource photoAtIndexPath:indexPath];
    CGFloat width = (CGRectGetWidth(self.collectionView.frame) / 2) - 20;
    CGFloat ratio = width / photo.size.width;
    CGFloat height = photo.size.height * ratio;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 45);
}

@end
