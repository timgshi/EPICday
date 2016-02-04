//
//  Channel.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Channel.h"

#import "Photo.h"
#import "Post.h"

#import <Firebase/Firebase.h>

@implementation Channel

+ (instancetype)channelFromRef:(Firebase *)ref {
    Channel *channel = [self new];
    channel.ref = ref;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *valuesDict = (NSDictionary *)snapshot.value;
        channel.name = valuesDict[@"name"];
        channel.avatarUrl = [NSURL URLWithString:valuesDict[@"avatarUrl"]];
    }];
    return channel;
}

- (NSString *)objectId {
    return self.ref.key;
}

- (NSUInteger)hash {
    return [self.objectId hash];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        Channel *c2 = (Channel *)object;
        return [c2.objectId isEqualToString:self.objectId];
    }
    return NO;
}

@end
