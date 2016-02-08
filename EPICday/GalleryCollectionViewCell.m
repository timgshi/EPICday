//
//  GalleryCollectionViewCell.m
//  EPICday
//
//  Created by Tim on 2/8/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "GalleryCollectionViewCell.h"

#import "UIColor+EPIC.h"

#import <Masonry/Masonry.h>

@implementation GalleryCollectionViewCell

+ (NSString *)defaultIdentifier {
    static NSString * const GalleryCollectionViewCellIdentifier = @"GalleryCollectionViewCellIdentifier";
    return GalleryCollectionViewCellIdentifier;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.thumbnailImageView = [UIImageView new];
        self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.thumbnailImageView.backgroundColor = [UIColor epicGrayColor];
        [self.contentView addSubview:self.thumbnailImageView];
        [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.thumbnailImageView.image = nil;
}

@end
