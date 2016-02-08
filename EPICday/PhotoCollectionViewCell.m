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

#import "UIColor+EPIC.h"

@interface PhotoCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGr;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGr;

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
        self.contentView.backgroundColor = [UIColor epicGrayColor];
        self.longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        self.longPressGr.minimumPressDuration = 0.5;
        [self.contentView addGestureRecognizer:self.longPressGr];
        self.tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self.tapGr requireGestureRecognizerToFail:self.longPressGr];
        [self.contentView addGestureRecognizer:self.tapGr];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.cellDidLongPressBlock = nil;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor epicGrayColor];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _imageView;
}

- (void)setPhoto:(Photo *)photo {
    _photo = photo;
    if (photo.thumbnail) {
        [self.imageView sd_setImageWithURL:photo.imageUrl placeholderImage:photo.thumbnail];
    } else {
        [self.imageView sd_setImageWithURL:photo.imageUrl];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tapGr {
    if (tapGr.state == UIGestureRecognizerStateEnded && self.cellDidTapBlock) {
        self.cellDidTapBlock(self);
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)pressGr {
    if (pressGr.state == UIGestureRecognizerStateBegan && self.cellDidLongPressBlock) {
        self.cellDidLongPressBlock(self);
    }
}

@end
