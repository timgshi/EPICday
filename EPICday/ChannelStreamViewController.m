//
//  ChannelStreamViewController.m
//  EPICday
//
//  Created by Tim Shi on 1/23/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "ChannelStreamViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Masonry/Masonry.h>

#import "Channel.h"
#import "ChannelStreamCollectionViewController.h"

@interface ChannelStreamViewController ()

@property (nonatomic, strong) ChannelStreamCollectionViewController *streamCollectionVC;


@end

@implementation ChannelStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.streamCollectionVC = [ChannelStreamCollectionViewController streamCollectionVCForChannel:[Channel objectWithoutDataWithObjectId:@"amqf4a9kPl"]];
    [self addChildViewController:self.streamCollectionVC];
    [self.view addSubview:self.streamCollectionVC.view];
    [self.streamCollectionVC didMoveToParentViewController:self];
    [self.streamCollectionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me/picture" parameters:@{@"type":@"large",@"redirect":@"false"}];
//    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//        NSLog(@"%@", result);
//        NSURL *url = [NSURL URLWithString:result[@"data"][@"url"]];
//        [imageView sd_setImageWithURL:url];
//    }];
}

@end
