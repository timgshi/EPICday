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
#import <FBSDKCoreKit/FBSDKCoreKit.h>

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
    [[[[PFFacebookUtils logInInBackgroundWithReadPermissions:readPermissions] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask<PFUser *> * _Nonnull task) {
        BFTaskCompletionSource *profileTaskSource = [BFTaskCompletionSource taskCompletionSource];
        BFTaskCompletionSource *profilePicTaskSource = [BFTaskCompletionSource taskCompletionSource];
        FBSDKGraphRequest *profileRequest = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me/?fields=email,first_name,last_name" parameters:nil];
        [profileRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            PFUser *user = [PFUser currentUser];
            user[@"first_name"] = result[@"first_name"];
            user[@"last_name"] = result[@"last_name"];
            user.email = result[@"email"];
            [profileTaskSource setResult:user];
        }];
        FBSDKGraphRequest *profilePicRequest = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me/picture?" parameters:@{@"type":@"large",@"redirect":@"false"}];
        [profilePicRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            NSString *url = result[@"data"][@"url"];
            [[PFUser currentUser] setObject:url forKey:@"profilePhotoUrl"];
            [profilePicTaskSource setResult:url];
        }];
        return [BFTask taskForCompletionOfAllTasks:@[profileTaskSource.task, profilePicTaskSource.task]];
    }] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        return [[PFUser currentUser] saveInBackground];
    }] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask<NSNumber *> * _Nonnull task) {
        [self pushChannelStreamVC:YES];
        return nil;
    }];
}

- (void)pushChannelStreamVC:(BOOL)animated {
    ChannelStreamViewController *streamVC = [ChannelStreamViewController new];
    [self.navigationController pushViewController:streamVC animated:animated];
}

@end
