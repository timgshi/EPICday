//
//  Post.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Post.h"

#import <Parse/PFObject+Subclass.h>

@implementation Post

@dynamic channel;
@dynamic user;

@synthesize photos;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Post";
}

@end
