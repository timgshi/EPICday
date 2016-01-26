//
//  Photo.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Photo.h"

#import <Parse/PFObject+Subclass.h>

@implementation Photo

@dynamic channel;
@dynamic post;
@dynamic originalTimestamp;
@dynamic user;
@dynamic dimensions;
@dynamic location;
@dynamic robbers;
@dynamic image;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Photo";
}

- (CGSize)size {
    return CGSizeMake([self.dimensions[@"width"] floatValue], [self.dimensions[@"height"] floatValue]);
}

@end
