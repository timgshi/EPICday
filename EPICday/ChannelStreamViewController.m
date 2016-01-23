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

@interface ChannelStreamViewController ()

@end

@implementation ChannelStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me/picture" parameters:@{@"type":@"large",@"redirect":@"false"}];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        NSLog(@"%@", result);
        NSURL *url = [NSURL URLWithString:result[@"data"][@"url"]];
        [imageView sd_setImageWithURL:url];
    }];
}

@end
