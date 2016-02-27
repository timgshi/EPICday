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

@property (nonatomic, strong) NSMutableArray *selectedAssets;

@end

@implementation ChannelGalleryPickerViewController

- (NSMutableArray *)selectedAssets {
    if (!_selectedAssets) {
        _selectedAssets = @[].mutableCopy;
    }
    return _selectedAssets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    self.galleryCollectionVC.collectionView.contentInset = UIEdgeInsetsMake(55, 0, 90, 0);
    [self addChildViewController:self.galleryCollectionVC];
    [self.view insertSubview:self.galleryCollectionVC.view belowSubview:self.channelBarView];
    [self.galleryCollectionVC didMoveToParentViewController:self];
    [self.galleryCollectionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"ic_close_white"] forState:UIControlStateNormal];
    [self.view addSubview:self.closeButton];
    
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.actionButton.titleLabel.font = [UIFont epicBoldFontOfSize:18];
    [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.actionButton setTitle:@"select images to add" forState:UIControlStateDisabled];
    [self.actionButton setTitle:@"share this image" forState:UIControlStateDisabled];
//    self.actionButton setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
}

@end
