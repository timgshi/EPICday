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
#import "ChannelGalleryPickerViewController.h"
#import "ChannelStreamCollectionViewController.h"
#import "UIColor+EPIC.h"
#import "UIFont+EPIC.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"

#import "FilteredCaptureViewController.h"

#import <AWSS3/AWSS3.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ChannelStreamViewController ()

@property (nonatomic, strong) ChannelStreamCollectionViewController *streamCollectionVC;
@property (nonatomic, strong) ChannelBarView *channelBarView;
@property (nonatomic, strong) BigCameraButton *cameraButton;

@property (nonatomic, strong) Firebase *baseRef, *selectedChannelRef;
@property (nonatomic, strong) Channel *selectedChannel;

@property (nonatomic, strong) UIView *notificationView;
@property (nonatomic, strong) UILabel *notificationViewLabel;
@property (nonatomic, strong) MASConstraint *notificationViewBottomConstraint;

@property (nonatomic, strong) UIImageView *fullScreenImageView;
@property (nonatomic, strong) UIPanGestureRecognizer *fullScreenImagePanGR;
@property (nonatomic) CGRect originalThumbFrame;

@property (nonatomic, strong) UIButton *addFromGalleryButton;

@end

@implementation ChannelStreamViewController

NSString * const EPICShowChannelStreamNotificationViewNotification = @"EPICShowChannelStreamNotificationViewNotification";
NSString * const EPICHideChannelStreamNotificationViewNotification = @"EPICHideChannelStreamNotificationViewNotification";
NSString * const EPICShowChannelStreamNotificationViewTextKey = @"EPICShowChannelStreamNotificationViewTextKey";
NSString * const EPICShowFullScreenImageFromCellNotification = @"EPICShowFullScreenImageFromCellNotification";

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
    
    NSString *channelId = EPIC_epicurrence_channel_id;
    self.baseRef = [[Firebase alloc] initWithUrl:@"https://incandescent-inferno-9043.firebaseio.com/"];
    self.selectedChannelRef = [self.baseRef childByAppendingPath:[NSString stringWithFormat:@"channels/%@", channelId]];
    [self.selectedChannelRef updateChildValues:@{[NSString stringWithFormat:@"members/%@", self.selectedChannelRef.authData.uid]: @YES}];
    BFTaskCompletionSource *channelInitialLoadTaskSource = [BFTaskCompletionSource taskCompletionSource];
    self.selectedChannel = [Channel channelFromRef:self.selectedChannelRef withInitialLoadTaskSource:channelInitialLoadTaskSource];
    
    [self.baseRef observeAuthEventWithBlock:^(FAuthData *authData) {
        NSLog(@"%@", authData);
    }];
    
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
    
    self.fullScreenImageView = [UIImageView new];
    self.fullScreenImageView.backgroundColor = [UIColor clearColor];
    self.fullScreenImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.fullScreenImageView.hidden = YES;
    self.fullScreenImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.fullScreenImageView];
    self.fullScreenImagePanGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleFullScreenImageDrag:)];
    self.fullScreenImagePanGR.enabled = NO;
    [self.fullScreenImageView addGestureRecognizer:self.fullScreenImagePanGR];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showFullScreenImageViewFromNotification:)
                                                 name:EPICShowFullScreenImageFromCellNotification object:nil];
    
    self.addFromGalleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addFromGalleryButton setImage:[UIImage imageNamed:@"add_gallery"] forState:UIControlStateNormal];
    [self.addFromGalleryButton addTarget:self action:@selector(galleryButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.channelBarView addSubview:self.addFromGalleryButton];
    [self.addFromGalleryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.channelBarView.avatarImageView.mas_centerY);
        make.right.equalTo(self.channelBarView.mas_right).with.offset(-15);
    }];
}

- (void)cameraButtonPressed {
    FilteredCaptureViewController *captureVC = [FilteredCaptureViewController new];
    captureVC.selectedChannel = self.selectedChannel;
    [self.navigationController pushViewController:captureVC animated:YES];
}

- (void)galleryButtonPressed {
    ChannelGalleryPickerViewController *galleryVC = [ChannelGalleryPickerViewController new];
    galleryVC.selectedChannel = self.selectedChannel;
    UINavigationController *galleryNav = [[UINavigationController alloc] initWithRootViewController:galleryVC];
    [self presentViewController:galleryNav animated:YES completion:nil];
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

- (void)showFullScreenImageViewFromNotification:(NSNotification *)notification {
    PhotoCollectionViewCell *cell = notification.object;
    [self.fullScreenImageView sd_setImageWithURL:cell.photo.imageUrl
                                placeholderImage:cell.photo.thumbnail];
    CGRect convertedFrame = [self.streamCollectionVC.collectionView convertRect:cell.frame toView:self.view];
    self.originalThumbFrame = convertedFrame;
    self.fullScreenImageView.frame = convertedFrame;
    self.fullScreenImageView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.fullScreenImageView.frame = self.view.bounds;
        self.fullScreenImageView.backgroundColor = [UIColor blackColor];
        self.fullScreenImagePanGR.enabled = YES;
    }];
}

- (void)hideFullScreenImageView {
    self.fullScreenImagePanGR.enabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.fullScreenImageView.frame = self.originalThumbFrame;
        self.fullScreenImageView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        self.fullScreenImageView.hidden = YES;
        self.fullScreenImageView.image = nil;
        self.originalThumbFrame = CGRectZero;
    }];
}

- (void)handleFullScreenImageDrag:(UIPanGestureRecognizer *)panGR {
    CGPoint translation = [panGR translationInView:self.view];
    if (panGR.state == UIGestureRecognizerStateBegan || panGR.state == UIGestureRecognizerStateChanged) {
        CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
        transform = CGAffineTransformTranslate(transform, translation.x, translation.y);
        self.fullScreenImageView.transform = transform;
//        CATransform3D transform = CATransform3DIdentity;
//        transform = CATransform3DScale(transform, 0.8, 0.8, 1.01);
//        transform = CATransform3DTranslate(transform, translation.x, translation.y, 0);
//        self.fullScreenImageView.layer.transform = transform;
    } else if (panGR.state == UIGestureRecognizerStateEnded) {
        CGFloat maxTranslation = MAX(translation.x, translation.y);
        if (maxTranslation >= 50) {
            [self hideFullScreenImageView];
        } else {
            self.fullScreenImageView.transform = CGAffineTransformIdentity;
//            self.fullScreenImageView.layer.transform = CATransform3DIdentity;
        }
    }
}

@end
