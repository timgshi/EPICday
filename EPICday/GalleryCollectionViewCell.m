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

@interface GalleryCollectionViewCell ()

@property (nonatomic, strong) UIView *selectedOverlayView;

@end

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
        self.selectedOverlayView = [UIView new];
        self.selectedOverlayView.hidden = YES;
        self.selectedOverlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self.contentView addSubview:self.selectedOverlayView];
        [self.selectedOverlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        UIImageView *checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_check_white"]];
        checkView.contentMode = UIViewContentModeScaleAspectFit;
        [self.selectedOverlayView addSubview:checkView];
        [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.selectedOverlayView);
        }];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.thumbnailImageView.image = nil;
    self.selectedOverlayView.hidden = YES;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectedOverlayView.hidden = !selected;
}

@end
