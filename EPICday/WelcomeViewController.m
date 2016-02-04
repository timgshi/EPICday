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
#import <Firebase/Firebase.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "ChannelStreamViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://incandescent-inferno-9043.firebaseio.com"];
    if (ref.authData) {
        [self pushChannelStreamVC:NO];
    }
}

- (IBAction)signinButtonPressed:(UIButton *)sender {
    NSArray *readPermissions = @[@"public_profile",
                                 @"email"];
    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://incandescent-inferno-9043.firebaseio.com"];
    FBSDKLoginManager *facebookLogin = [FBSDKLoginManager new];
    [facebookLogin logInWithReadPermissions:readPermissions fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Facebook login failed. Error: %@", error);
        } else if (result.isCancelled) {
            NSLog(@"Facebook login got cancelled.");
        } else {
            NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
            [ref authWithOAuthProvider:@"facebook" token:accessToken
                   withCompletionBlock:^(NSError *error, FAuthData *authData) {
                       if (error) {
                           NSLog(@"Login failed. %@", error);
                       } else {
                           NSLog(@"Logged in! %@", authData);
                           NSDictionary *newUser = @{
                                                     @"provider": authData.provider,
                                                     @"provider_id": authData.providerData[@"id"],
                                                     @"display_name": authData.providerData[@"displayName"],
                                                     @"first_name": authData.providerData[@"cachedUserProfile"][@"first_name"],
                                                     @"last_name": authData.providerData[@"cachedUserProfile"][@"last_name"],
                                                     @"email": authData.providerData[@"email"],
                                                     @"profile_image_url": authData.providerData[@"profileImageURL"]
                                                     };
                           // Create a child path with a key set to the uid underneath the "users" node
                           // This creates a URL path like the following:
                           //  - https://<YOUR-FIREBASE-APP>.firebaseio.com/users/<uid>
                           [[[ref childByAppendingPath:@"users"]
                             childByAppendingPath:authData.uid] setValue:newUser withCompletionBlock:^(NSError *error, Firebase *ref) {
                               [self pushChannelStreamVC:YES];
                           }];
                           
                       }
                   }];
        }
    }];
}

- (void)pushChannelStreamVC:(BOOL)animated {
    ChannelStreamViewController *streamVC = [ChannelStreamViewController new];
    [self.navigationController pushViewController:streamVC animated:animated];
}

@end
