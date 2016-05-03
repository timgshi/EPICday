//
//  Channel.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Channel.h"

#import "User.h"
#import "Photo.h"
#import "Post.h"

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>

@interface Channel ()

@property (nonatomic, strong) NSArray *memberThumbUrls;

@end

@implementation Channel

NSString * const EPICChannelDidUpdatePostsNotification = @"EPICChannelDidUpdatePostsNotification";

+ (instancetype)channelFromRef:(Firebase *)ref withInitialLoadTaskSource:(BFTaskCompletionSource *)taskSource {
    Channel *channel = [self new];
    channel.ref = ref;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary *valuesDict = (NSDictionary *)snapshot.value;
        channel.name = valuesDict[@"name"];
        channel.avatarUrl = [NSURL URLWithString:valuesDict[@"avatarUrl"]];
        channel.membersDict = valuesDict[@"members"];
        channel.memberThumbUrls = nil;
        channel.purpose = valuesDict[@"purpose"] ?: @"";
        [taskSource trySetResult:channel];
    }];
    return channel;
}

- (NSMutableOrderedSet *)posts {
    if (!_posts) {
        _posts = [NSMutableOrderedSet orderedSet];
    }
    return _posts;
}

- (BFTask *)fetchMemberThumbUrls {
    BFTaskCompletionSource *taskSource = [BFTaskCompletionSource taskCompletionSource];
    if (!self.memberThumbUrls) {
        NSMutableArray *urls = @[].mutableCopy;
        NSMutableArray *tasks = @[].mutableCopy;
        [self.membersDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *val, BOOL * _Nonnull stop) {
            BFTask *task = [[User asyncUserFromRef:[[self.ref.root childByAppendingPath:@"users"] childByAppendingPath:key]] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
                User *user = task.result;
                [urls addObject:user.avatarUrl];
                return nil;
            }];
            [tasks addObject:task];
        }];
        [[BFTask taskForCompletionOfAllTasks:tasks] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
            self.memberThumbUrls = urls;
            [taskSource trySetResult:urls];
            return nil;
        }];
    } else {
        [taskSource trySetResult:self.memberThumbUrls];
    }
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
        Channel *c2 = (Channel *)object;
        return [c2.objectId isEqualToString:self.objectId];
    }
    return NO;
}

- (Firebase *)createRefForNewPost {
    Firebase *ref = [[[self.ref root] childByAppendingPath:@"posts"] childByAutoId];
    NSDictionary *postValues = @{
                                 @"channel": self.ref.key,
                                 @"timestamp": @([[NSDate date] timeIntervalSince1970]),
                                 @"user": self.ref.authData.uid
                                 };
    [ref setValue:postValues];
    [self.ref updateChildValues:@{[NSString stringWithFormat:@"posts/%@", ref.key]: @YES}];
    return ref;
}

@end
