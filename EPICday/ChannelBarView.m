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
#import <Firebase/Firebase.h>

#import "UIColor+EPIC.h"
#import "UIFont+EPIC.h"

@interface ChannelBarView ()

@property (nonatomic, strong) Channel *selectedChannel;
@property (nonatomic, copy) NSString *selectedChannelId;
@property (nonatomic, strong) Firebase *selectedChannelRef;
@property (nonatomic) FirebaseHandle selectedChannelHandle;

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

+ (instancetype)barViewWithChannelId:(NSString *)channelId {
    ChannelBarView *barView = [self new];
    barView.selectedChannelId = channelId;
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
    
    self.backgroundColor = [UIColor epicDarkGrayColor];
    
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
    [self updateUIWithChannel:selectedChannel];
}

- (void)setSelectedChannelId:(NSString *)selectedChannelId {
    _selectedChannelId = [selectedChannelId copy];
    if (self.selectedChannelRef) {
        [self.selectedChannelRef removeObserverWithHandle:self.selectedChannelHandle];
    }
    NSString *channelRefUrl = [NSString stringWithFormat:@"https://incandescent-inferno-9043.firebaseio.com/channels/%@", selectedChannelId];
    self.selectedChannelRef = [[Firebase alloc] initWithUrl:channelRefUrl];
    self.selectedChannelHandle = [self.selectedChannelRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        self.channelNameLabel.text = snapshot.value[@"name"];
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:snapshot.value[@"avatar"]]];
        UIImage *avatarImage = [UIImage imageWithData:imgData];
        self.avatarImageView.image = avatarImage;
        NSInteger memberCount = [snapshot.value[@"members"] allKeys].count - 1;
        NSString *memberCountText = [NSString stringWithFormat:@"w/ %lu other", memberCount];
        if (memberCount != 1) {
            memberCountText = [memberCountText stringByAppendingString:@"s"];
        }
        self.memberCountLabel.text = memberCountText;
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
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(kMargin);
            make.top.equalTo(self.mas_top).with.offset(kVerticalMargin);
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

- (void)updateUIWithChannel:(Channel *)channel {
    NSURL *avatarUrl = [NSURL URLWithString:channel.avatar.url];
    [self.avatarImageView sd_setImageWithURL:avatarUrl];
    self.channelNameLabel.text = channel.name;
    NSInteger memberCount = channel.members.count - 1;
    NSString *memberCountText = [NSString stringWithFormat:@"w/ %lu other", memberCount];
    if (memberCount != 1) {
        memberCountText = [memberCountText stringByAppendingString:@"s"];
    }
    self.memberCountLabel.text = memberCountText;
}

@end
