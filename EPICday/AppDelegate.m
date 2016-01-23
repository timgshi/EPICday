//
//  AppDelegate.m
//  EPICday
//
//  Created by Tim Shi on 1/23/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "AppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

static NSString * const kParseAppId = @"rJDwVv590kVJtyU4IY92aeHmTPqGurXxch4AJuMt";
static NSString * const kParseClientKey = @"S3yi7Ny8cFasV10YGZsROlbPO2tz5WAYIvGPEE6z";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:kParseAppId
                  clientKey:kParseClientKey];
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
