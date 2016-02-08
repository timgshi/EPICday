//
//  GalleryCollectionViewCell.h
//  EPICday
//
//  Created by Tim on 2/8/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, copy) NSString *representedAssetIdentifier;

+ (NSString *)defaultIdentifier;

@end
