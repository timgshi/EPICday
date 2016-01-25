//
//  PhotoCollectionViewCell.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

+ (NSString *)defaultIdentifier {
    static NSString * const PhotoCollectionViewCellIdentifier = @"PhotoCollectionViewCellIdentifier";
    return PhotoCollectionViewCellIdentifier;
}

+ (void)registerWithCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:self forCellWithReuseIdentifier:[self defaultIdentifier]];
}

@end
