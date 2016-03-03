//
//  User.m
//  EPICday
//
//  Created by Tim on 2/3/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "User.h"

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>

@implementation User

+ (instancetype)userFromRef:(Firebase *)ref {
    User *user = [self new];
    user.ref = ref;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        user.displayName = snapshot.value[@"display_name"];
        user.avatarUrl = [NSURL URLWithString:snapshot.value[@"profile_image_url"]];
    }];
    return user;
}

+ (BFTask *)asyncUserFromRef:(Firebase *)ref {
    BFTaskCompletionSource *taskSource = [BFTaskCompletionSource taskCompletionSource];
    User *user = [self new];
    user.ref = ref;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        user.displayName = snapshot.value[@"display_name"];
        user.avatarUrl = [NSURL URLWithString:snapshot.value[@"profile_image_url"]];
        [taskSource trySetResult:user];
    }];
    return taskSource.task;
}

- (NSString *)objectId {
    return self.ref.key;
}

- (NSUInteger)hash {
    return [self.objectId hash];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        User *u2 = (User *)object;
        return [u2.objectId isEqualToString:self.objectId];
    }
    return NO;
}

@end
