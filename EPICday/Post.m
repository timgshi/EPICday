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

@synthesize photos = _photos;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Post";
}

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = @[].mutableCopy;
    }
    return _photos;
}

- (NSUInteger)hash {
    return self.objectId.hash;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        Post *p2 = (Post *)object;
        return [self.objectId isEqualToString:p2.objectId];
    }
    return NO;
}

@end
