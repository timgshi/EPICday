//
//  Channel.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Channel.h"

#import <Parse/PFObject+Subclass.h>

@implementation Channel

@dynamic name;
@dynamic members;
@dynamic avatar;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Channel";
}

@end
