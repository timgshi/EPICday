//
//  BigCameraButton.m
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "BigCameraButton.h"

#import <Masonry/Masonry.h>

#import "UIColor+EPIC.h"

@interface BigCameraButton()

@property (nonatomic) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *outerCircleView, *innerCircleView;

@property (nonatomic) BOOL hasInstalledViewConstraints;

@end

@implementation BigCameraButton

+ (instancetype)button {
    BigCameraButton *button = [self buttonWithType:UIButtonTypeCustom];
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)createViews {
    self.backgroundColor = [UIColor clearColor];
    
    self.outerCircleView = [UIView new];
    self.outerCircleView.userInteractionEnabled = NO;
    self.outerCircleView.backgroundColor = [UIColor epicRedColor];
    [self addSubview:self.outerCircleView];
    
    self.innerCircleView = [UIView new];
    self.innerCircleView.userInteractionEnabled = NO;
    self.innerCircleView.backgroundColor = [UIColor epicLightRedColor];
    [self addSubview:self.innerCircleView];
    
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_photo_camera_white"]];
    self.iconImageView.userInteractionEnabled = NO;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconImageView];
}

- (void)updateConstraints {
    [self installViewConstraintsIfNecessary];
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.outerCircleView.layer.cornerRadius = CGRectGetHeight(self.outerCircleView.frame) / 2;
    self.innerCircleView.layer.cornerRadius = CGRectGetHeight(self.innerCircleView.frame) / 2;
}

- (void)installViewConstraintsIfNecessary {
    if (!self.hasInstalledViewConstraints) {
        self.hasInstalledViewConstraints = YES;
        
        [self.outerCircleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.innerCircleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
}

- (void)setShowsCameraIcon:(BOOL)showsCameraIcon {
    _showsCameraIcon = showsCameraIcon;
    self.iconImageView.hidden = !showsCameraIcon;
}

- (void)animateToStopButton {
    [UIView animateWithDuration:0.3 animations:^{
        self.outerCircleView.layer.cornerRadius = 4;
        self.innerCircleView.layer.cornerRadius = 4;
    }];
}

- (void)animateToRecordButton {
    [UIView animateWithDuration:0.3 animations:^{
        self.outerCircleView.layer.cornerRadius = CGRectGetHeight(self.outerCircleView.frame) / 2;
        self.innerCircleView.layer.cornerRadius = CGRectGetHeight(self.innerCircleView.frame) / 2;
    }];
}

@end
