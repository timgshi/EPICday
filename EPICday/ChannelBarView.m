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

@interface ChannelBarView ()

@property (nonatomic, strong) Channel *selectedChannel;

@property (nonatomic) BOOL hasInstalledViewConstraints;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *channelNameLabel;
@property (nonatomic, strong) UILabel *memberCountLabel;

@end

@implementation ChannelBarView

+ (instancetype)barViewWithSelectedChannel:(Channel *)channel {
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
    self.avatarImageView = [UIImageView new];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.layer.cornerRadius = 5;
    [self addSubview:self.avatarImageView];
    
    
}

- (void)setSelectedChannel:(Channel *)selectedChannel {
    _selectedChannel = selectedChannel;
    [self updateUIWithChannel:selectedChannel];
}

- (void)updateConstraints {
    [self installViewConstraintsIfNecessary];
    [super updateConstraints];
}

- (void)installViewConstraintsIfNecessary {
    if (!self.hasInstalledViewConstraints) {
        self.hasInstalledViewConstraints = YES;
        
        const CGFloat kMargin = 15;
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kMargin);
            make.top.equalTo(self.mas_top).with.offset(kMargin);
            make.bottom.equalTo(self.mas_bottom).with.offset(-kMargin);
            make.width.equalTo(self.avatarImageView.mas_height);
        }];
        [self.channelNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(kMargin);
            make.top.equalTo(self.mas_top).with.offset(kMargin);
        }];
        [self.memberCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
}

- (void)updateUIWithChannel:(Channel *)channel {
    NSURL *avatarUrl = [NSURL URLWithString:channel.avatar.url];
    [self.avatarImageView sd_setImageWithURL:avatarUrl];
    self.channelNameLabel.text = channel.name;
    NSString *memberCountText = [NSString stringWithFormat:@"w/ %lu other", (channel.members.count - 1)];
    if (channel.members.count > 2) {
        memberCountText = [memberCountText stringByAppendingString:@"s"];
    }
    self.channelNameLabel.text = memberCountText;
}

@end
