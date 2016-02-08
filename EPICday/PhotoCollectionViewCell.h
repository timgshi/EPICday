//
//  PhotoCollectionViewCell.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Photo.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) Photo *photo;
@property (nonatomic, copy) void (^cellDidTapBlock)(PhotoCollectionViewCell *cell);
@property (nonatomic, copy) void (^cellDidLongPressBlock)(PhotoCollectionViewCell *cell);

+ (NSString *)defaultIdentifier;
+ (void)registerWithCollectionView:(UICollectionView *)collectionView;

@end
