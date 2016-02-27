//
//  ChannelGalleryPickerViewController.m
//  EPICday
//
//  Created by Tim on 2/8/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "ChannelGalleryPickerViewController.h"

#import "Channel.h"
#import "ChannelBarView.h"
#import "GalleryCollectionViewController.h"
#import "UIColor+EPIC.h"
#import "UIFont+EPIC.h"

#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ChannelGalleryPickerViewController ()

@property (nonatomic, strong) ChannelBarView *channelBarView;
@property (nonatomic, strong) GalleryCollectionViewController *galleryCollectionVC;
@property (nonatomic, strong) UIButton *closeButton, *actionButton;

@end

@implementation ChannelGalleryPickerViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    const CGFloat kActionBarHeight = 55;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    
    self.view.backgroundColor = [UIColor epicDarkGrayColor];
    
    self.channelBarView = [ChannelBarView barViewWithChannel:self.selectedChannel];
    [self.view addSubview:self.channelBarView];
    [self.channelBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(55 + statusBarHeight));
    }];
    
    self.galleryCollectionVC = [GalleryCollectionViewController galleryCollectionPickerVC];
    self.galleryCollectionVC.collectionView.contentInset = UIEdgeInsetsMake(55, 0, kActionBarHeight, 0);
    __weak typeof(self) weakSelf = self;
    self.galleryCollectionVC.selectionBlock = ^(GalleryCollectionViewController *galleryCollectionVC) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf updateActionButtonWithCount:galleryCollectionVC.selectedAssets.count];
    };
    [self addChildViewController:self.galleryCollectionVC];
    [self.view insertSubview:self.galleryCollectionVC.view belowSubview:self.channelBarView];
    [self.galleryCollectionVC didMoveToParentViewController:self];
    [self.galleryCollectionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"ic_close_white"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.channelBarView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.channelBarView.avatarImageView.mas_centerY);
        make.right.equalTo(self.channelBarView.mas_right).with.offset(-15);
    }];
    
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.actionButton.enabled = NO;
    self.actionButton.titleLabel.font = [UIFont epicBoldFontOfSize:18];
    [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.actionButton setTitle:@"select images to add" forState:UIControlStateDisabled];
    [self.actionButton setTitle:@"share this image" forState:UIControlStateNormal];
    [self.actionButton setBackgroundImage:[[UIColor epicDarkGrayColor] image] forState:UIControlStateDisabled];
    [self.actionButton setBackgroundImage:[[UIColor epicGreenColor] image] forState:UIControlStateNormal];
    [self.view addSubview:self.actionButton];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@(kActionBarHeight));
    }];
}

- (void)closeButtonPressed {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateActionButtonWithCount:(NSInteger)count {
    if (count == 1) {
        [self.actionButton setTitle:@"share this image" forState:UIControlStateNormal];
        self.actionButton.enabled = YES;
    } else if (count > 1) {
        NSString *title = [NSString stringWithFormat:@"share these %lu images", count];
        [self.actionButton setTitle:title forState:UIControlStateNormal];
        self.actionButton.enabled = YES;
    } else {
        self.actionButton.enabled = NO;
    }
}

@end
