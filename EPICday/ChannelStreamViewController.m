//
//  ChannelStreamViewController.m
//  EPICday
//
//  Created by Tim Shi on 1/23/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "ChannelStreamViewController.h"

#import <Bolts/Bolts.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Masonry/Masonry.h>

#import <Firebase/Firebase.h>

#import "BigCameraButton.h"
#import "CaptureViewController.h"
#import "Channel.h"
#import "ChannelBarView.h"
#import "ChannelStreamCollectionViewController.h"
#import "UIColor+EPIC.h"
#import "UIFont+EPIC.h"

#import "FilteredCaptureViewController.h"

#import <AWSS3/AWSS3.h>

@interface ChannelStreamViewController ()

@property (nonatomic, strong) ChannelStreamCollectionViewController *streamCollectionVC;
@property (nonatomic, strong) ChannelBarView *channelBarView;
@property (nonatomic, strong) BigCameraButton *cameraButton;

@property (nonatomic, strong) Firebase *baseRef, *selectedChannelRef;
@property (nonatomic, strong) Channel *selectedChannel;

@property (nonatomic, strong) UIView *notificationView;
@property (nonatomic, strong) UILabel *notificationViewLabel;
@property (nonatomic, strong) MASConstraint *notificationViewBottomConstraint;

@end

@implementation ChannelStreamViewController

NSString * const EPICShowChannelStreamNotificationViewNotification = @"EPICShowChannelStreamNotificationViewNotification";
NSString * const EPICHideChannelStreamNotificationViewNotification = @"EPICHideChannelStreamNotificationViewNotification";
NSString * const EPICShowChannelStreamNotificationViewTextKey = @"EPICShowChannelStreamNotificationViewTextKey";

static NSString * const EPIC_epicurrence_test_channel_id = @"-K9BFMuy_74cIqk9RUz9";
static NSString * const EPIC_epicurrence_channel_id = @"-KA-1sbul1bQREXo6_sa";

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    
    NSString *channelId = EPIC_epicurrence_test_channel_id;
    self.baseRef = [[Firebase alloc] initWithUrl:@"https://incandescent-inferno-9043.firebaseio.com/"];
    self.selectedChannelRef = [self.baseRef childByAppendingPath:[NSString stringWithFormat:@"channels/%@", channelId]];
    [self.selectedChannelRef updateChildValues:@{[NSString stringWithFormat:@"members/%@", self.selectedChannelRef.authData.uid]: @YES}];
    BFTaskCompletionSource *channelInitialLoadTaskSource = [BFTaskCompletionSource taskCompletionSource];
    self.selectedChannel = [Channel channelFromRef:self.selectedChannelRef withInitialLoadTaskSource:channelInitialLoadTaskSource];
    
    self.channelBarView = [ChannelBarView barViewWithChannel:self.selectedChannel];
    [self.view addSubview:self.channelBarView];
    [self.channelBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(55 + statusBarHeight));
    }];
    
    self.view.backgroundColor = [UIColor epicDarkGrayColor];
    
    self.streamCollectionVC = [ChannelStreamCollectionViewController streamCollectionVCForChannel:self.selectedChannel];
    [channelInitialLoadTaskSource.task continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        [self.streamCollectionVC.collectionView reloadData];
        return nil;
    }];
    [self addChildViewController:self.streamCollectionVC];
    [self.view insertSubview:self.streamCollectionVC.view belowSubview:self.channelBarView];
    [self.streamCollectionVC didMoveToParentViewController:self];
    [self.streamCollectionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    
    self.cameraButton = [BigCameraButton button];
    [self.cameraButton addTarget:self action:@selector(cameraButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cameraButton];
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@72);
        make.width.equalTo(self.cameraButton.mas_height);
    }];
    
    self.notificationView = [UIView new];
    self.notificationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.notificationView];
    UIView *notificationBorderView = [UIView new];
    notificationBorderView.backgroundColor = [UIColor epicDarkGrayColor];
    [self.notificationView addSubview:notificationBorderView];
    
    self.notificationViewLabel = [UILabel new];
    self.notificationViewLabel.textAlignment = NSTextAlignmentLeft;
    self.notificationViewLabel.textColor = [UIColor epicDarkGrayColor];
    self.notificationViewLabel.font = [UIFont epicDefaultFontOfSize:22];
    [self.notificationView addSubview:self.notificationViewLabel];
    
    self.notificationViewLabel.text = @"Hold to save photo";
    
    [self.notificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(self.channelBarView.mas_height);
        make.bottom.equalTo(self.view.mas_top);
    }];
    [notificationBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.notificationView.mas_left);
        make.right.equalTo(self.notificationView.mas_right);
        make.top.equalTo(self.notificationView.mas_top);
        make.height.equalTo(@(statusBarHeight));
    }];
    [self.notificationViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.notificationView.mas_left).with.offset(15);
        make.right.equalTo(self.notificationView.mas_right).with.offset(-15);
        make.top.equalTo(notificationBorderView.mas_bottom);
        make.bottom.equalTo(self.notificationView.mas_bottom);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotificationView:) name:EPICShowChannelStreamNotificationViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNotificationView:) name:EPICHideChannelStreamNotificationViewNotification object:nil];
    
}

- (void)cameraButtonPressed {
    FilteredCaptureViewController *captureVC = [FilteredCaptureViewController new];
    captureVC.selectedChannel = self.selectedChannel;
    [self.navigationController pushViewController:captureVC animated:YES];
}

- (void)showNotificationView:(NSNotification *)notification {
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(hideNotificationView:)
                                               object:nil];
    self.notificationViewLabel.text = notification.userInfo[EPICShowChannelStreamNotificationViewTextKey];
    [self.view layoutIfNeeded];
    [self.notificationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_top).with.offset(CGRectGetHeight(self.notificationView.frame));
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self performSelector:@selector(hideNotificationView:) withObject:nil afterDelay:3];
}

- (void)hideNotificationView:(NSNotification *)notification {
    [self.view layoutIfNeeded];
    [self.notificationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_top).with.offset(0);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
