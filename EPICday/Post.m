//
//  Post.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Post.h"

#import <Firebase/Firebase.h>

@implementation Post

@synthesize photos = _photos;

+ (NSArray *)postsFromSnapshot:(FDataSnapshot *)snapshot {
    NSDictionary *snapshotPosts = snapshot.value;
    NSMutableArray *posts = @[].mutableCopy;
    [snapshotPosts enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *postDict, BOOL * _Nonnull stop) {
        Post *post = [self postFromRef:[snapshot.ref childByAppendingPath:key]];
        [posts addObject:post];
    }];
    return posts;
}

+ (instancetype)postFromRef:(Firebase *)ref {
    Post *post = [self new];
    post.ref = ref;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        post.channelId = snapshot.value[@"channel"];
        post.timestamp = [NSDate dateWithTimeIntervalSince1970:[snapshot.value[@"timestamp"] doubleValue]];
        
    }];
    return post;
}

@end
