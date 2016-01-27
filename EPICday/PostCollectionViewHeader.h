//
//  PostCollectionViewHeader.h
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Post.h"

@interface PostCollectionViewHeader : UICollectionReusableView

@property (nonatomic, strong) Post *post;

+ (NSString *)defaultIdentifier;
+ (void)registerWithCollectionView:(UICollectionView *)collectionView;

@end
