//
//  PhotoCollectionViewCell.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

+ (NSString *)defaultIdentifier;
+ (void)registerWithCollectionView:(UICollectionView *)collectionView;

@end
