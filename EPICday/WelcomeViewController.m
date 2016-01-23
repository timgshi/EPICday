//
//  ViewController.m
//  EPICday
//
//  Created by Tim Shi on 1/23/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "WelcomeViewController.h"

#import <Bolts/Bolts.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

#import "ChannelStreamViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([PFUser currentUser]) {
        [self pushChannelStreamVC:NO];
    }
}

- (IBAction)signinButtonPressed:(UIButton *)sender {
    NSArray *readPermissions = @[@"public_profile",
                                 @"email"];
    [[PFFacebookUtils logInInBackgroundWithReadPermissions:readPermissions] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask<PFUser *> * _Nonnull task) {
        [self pushChannelStreamVC:YES];
        return nil;
    }];
}

- (void)pushChannelStreamVC:(BOOL)animated {
    ChannelStreamViewController *streamVC = [ChannelStreamViewController new];
    [self.navigationController pushViewController:streamVC animated:animated];
}

@end
