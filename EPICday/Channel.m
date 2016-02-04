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

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>

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
        NSMutableArray *postsInitialLoadTasks = @[].mutableCopy;
        NSDictionary *snapshotPosts = snapshot.value[@"posts"];
        [snapshotPosts enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            BFTaskCompletionSource *postTaskSource = nil;
            if (taskSource && !taskSource.task.completed) {
                postTaskSource = [BFTaskCompletionSource taskCompletionSource];
                [postsInitialLoadTasks addObject:postTaskSource.task];
            }
            Firebase *postRef = [[[ref root] childByAppendingPath:@"posts"] childByAppendingPath:key];
            Post *post = [Post postFromRef:postRef inChannel:channel withInitialLoadTaskSource:postTaskSource];
            [channel.posts addObject:post];
        }];
        if (taskSource && !taskSource.task.completed) {
            [[BFTask taskForCompletionOfAllTasks:postsInitialLoadTasks] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
                [channel.posts sortUsingComparator:^NSComparisonResult(Post *p1, Post *p2) {
                    return [p2.timestamp compare:p1.timestamp];
                }];
                [taskSource trySetResult:@YES];
                return nil;
            }];
        } else {
            [channel.posts sortUsingComparator:^NSComparisonResult(Post *p1, Post *p2) {
                return [p2.timestamp compare:p1.timestamp];
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:EPICChannelDidUpdatePostsNotification
                                                                object:self];
        }
    }];
    return channel;
}

- (NSMutableOrderedSet *)posts {
    if (!_posts) {
        _posts = [NSMutableOrderedSet orderedSet];
    }
    return _posts;
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
