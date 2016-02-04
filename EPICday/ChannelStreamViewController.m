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
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Masonry/Masonry.h>

#import <Firebase/Firebase.h>

#import "BigCameraButton.h"
#import "CaptureViewController.h"
#import "Channel.h"
#import "ChannelBarView.h"
#import "ChannelStreamCollectionViewController.h"
#import "UIColor+EPIC.h"

@interface ChannelStreamViewController ()

@property (nonatomic, strong) ChannelStreamCollectionViewController *streamCollectionVC;
@property (nonatomic, strong) ChannelBarView *channelBarView;
@property (nonatomic, strong) BigCameraButton *cameraButton;

@property (nonatomic, strong) Firebase *baseRef, *selectedChannelRef;
@property (nonatomic, strong) Channel *selectedChannel;

@end

@implementation ChannelStreamViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    
    NSString *channelId = @"-K9BFMuy_74cIqk9RUz9";
    self.baseRef = [[Firebase alloc] initWithUrl:@"https://incandescent-inferno-9043.firebaseio.com/"];
    self.selectedChannelRef = [self.baseRef childByAppendingPath:[NSString stringWithFormat:@"channels/%@", channelId]];
    BFTaskCompletionSource *channelInitialLoadTaskSource = [BFTaskCompletionSource taskCompletionSource];
    self.selectedChannel = [Channel channelFromRef:self.selectedChannelRef withInitialLoadTaskSource:channelInitialLoadTaskSource];
    
    self.channelBarView = [ChannelBarView barViewWithChannel:self.selectedChannel];
    [self.view addSubview:self.channelBarView];
    [self.channelBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(statusBarHeight);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@55);
    }];
    
    self.view.backgroundColor = [UIColor epicDarkGrayColor];
    
    self.streamCollectionVC = [ChannelStreamCollectionViewController streamCollectionVCForChannel:self.selectedChannel];
    [channelInitialLoadTaskSource.task continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        [self.streamCollectionVC.collectionView reloadData];
        return nil;
    }];
    [self addChildViewController:self.streamCollectionVC];
    [self.view addSubview:self.streamCollectionVC.view];
    [self.streamCollectionVC didMoveToParentViewController:self];
    [self.streamCollectionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelBarView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    
    self.cameraButton = [BigCameraButton button];
    [self.cameraButton addTarget:self action:@selector(cameraButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cameraButton];
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@72);
        make.width.equalTo(self.cameraButton.mas_height);
    }];
}

- (void)cameraButtonPressed {
    CaptureViewController *captureVC = [CaptureViewController new];
    [self.navigationController pushViewController:captureVC animated:YES];
}

@end
