//
//  Post.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Post.h"

#import "Photo.h"

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
//        post.channelId = snapshot.value[@"channel"];
        post.timestamp = [NSDate dateWithTimeIntervalSince1970:[snapshot.value[@"timestamp"] doubleValue]];
        NSDictionary *snapshotPhotos = snapshot.value[@"photos"];
        [snapshotPhotos enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            Firebase *photoRef = [[[ref root] childByAppendingPath:@"photos"] childByAppendingPath:key];
            Photo *photo = [Photo photoFromRef:photoRef inPost:post];
            [post.photos addObject:photo];
        }];
        [post.photos sortUsingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
            return [p1.timestamp compare:p2.timestamp];
        }];
    }];
    return post;
}

- (NSMutableOrderedSet *)photos {
    if (!_photos) {
        _photos = [NSMutableOrderedSet orderedSet];
    }
    return _photos;
}

- (NSString *)objectId {
    return self.ref.key;
}

- (NSUInteger)hash {
    return [self.objectId hash];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        Post *p2 = (Post *)object;
        return [p2.objectId isEqualToString:self.objectId];
    }
    return NO;
}

@end
