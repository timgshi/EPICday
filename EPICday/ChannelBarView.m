//
//  ChannelBarView.m
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "ChannelBarView.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "UIColor+EPIC.h"
#import "UIFont+EPIC.h"

@interface ChannelBarView ()

@property (nonatomic, strong) Channel *selectedChannel;

@property (nonatomic) BOOL hasInstalledViewConstraints;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *channelNameLabel;
@property (nonatomic, strong) UILabel *memberCountLabel;

@end

@implementation ChannelBarView

+ (instancetype)barViewWithChannel:(Channel *)channel {
    ChannelBarView *barView = [self new];
    barView.selectedChannel = channel;
    return barView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)createViews {
    
    self.backgroundColor = [[UIColor epicDarkGrayColor] colorWithAlphaComponent:0.7];
    
    self.avatarImageView = [UIImageView new];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.layer.cornerRadius = 5;
    self.avatarImageView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.avatarImageView];
    
    self.channelNameLabel = [UILabel new];
    self.channelNameLabel.font = [UIFont epicBoldFontOfSize:16];
    self.channelNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.channelNameLabel];
    
    self.memberCountLabel = [UILabel new];
    self.memberCountLabel.font = [UIFont epicLightFontOfSize:12];
    self.memberCountLabel.textColor = [UIColor epicLightGrayColor];
    [self addSubview:self.memberCountLabel];
}

- (void)setSelectedChannel:(Channel *)selectedChannel {
    _selectedChannel = selectedChannel;
    RAC(self.channelNameLabel, text) = [selectedChannel rac_valuesForKeyPath:@"name" observer:self];
    [RACObserve(selectedChannel, avatarUrl) subscribeNext:^(NSURL *avatarUrl) {
        [self.avatarImageView sd_setImageWithURL:avatarUrl];
    }];
    RAC(self.memberCountLabel, text) = [[RACObserve(selectedChannel, membersDict) takeUntil:self.rac_willDeallocSignal] map:^id(NSDictionary *membersDict) {
        NSInteger othersCount = MAX(0, membersDict.count - 1);
        NSString *text =  [NSString stringWithFormat:@"w/ %ld other", (long)othersCount];
        if (othersCount != 1) {
            text = [text stringByAppendingString:@"s"];
        }
        return text;
    }];
}

- (void)updateConstraints {
    [self installViewConstraintsIfNecessary];
    [super updateConstraints];
}

- (void)installViewConstraintsIfNecessary {
    if (!self.hasInstalledViewConstraints) {
        self.hasInstalledViewConstraints = YES;
        
        const CGFloat kMargin = 15;
        const CGFloat kVerticalMargin = 10;
        
        CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kMargin);
            make.top.equalTo(self.mas_top).with.offset(kVerticalMargin + statusBarHeight);
            make.bottom.equalTo(self.mas_bottom).with.offset(-kVerticalMargin);
            make.width.equalTo(self.avatarImageView.mas_height);
        }];
        [self.channelNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(kMargin);
            make.top.equalTo(self.avatarImageView.mas_top);
        }];
        [self.memberCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(kMargin);
            make.bottom.equalTo(self.avatarImageView.mas_bottom);
        }];
    }
}

@end
