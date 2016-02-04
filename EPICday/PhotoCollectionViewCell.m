//
//  PhotoCollectionViewCell.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface PhotoCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PhotoCollectionViewCell

+ (NSString *)defaultIdentifier {
    static NSString * const PhotoCollectionViewCellIdentifier = @"PhotoCollectionViewCellIdentifier";
    return PhotoCollectionViewCellIdentifier;
}

+ (void)registerWithCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:self forCellWithReuseIdentifier:[self defaultIdentifier]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _imageView;
}

- (void)setPhoto:(Photo *)photo {
    _photo = photo;
    [self.imageView sd_setImageWithURL:photo.imageUrl];
}

@end
