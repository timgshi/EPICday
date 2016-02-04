//
//  Post.m
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Post.h"

#import "Photo.h"

#import <Bolts/Bolts.h>
#import <Firebase/Firebase.h>

@implementation Post

NSString * const EPICPostDidUpdatePhotosNotification = @"EPICPostDidUpdatePhotosNotification";

@synthesize photos = _photos;

+ (instancetype)postFromRef:(Firebase *)ref inChannel:(Channel *)channel withInitialLoadTaskSource:(BFTaskCompletionSource *)taskSource {
    Post *post = [self new];
    post.ref = ref;
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        post.channel = channel;
        post.timestamp = [NSDate dateWithTimeIntervalSince1970:[snapshot.value[@"timestamp"] doubleValue]];
        post.userRef = [[[ref root] childByAppendingPath:@"users"] childByAppendingPath:snapshot.value[@"user"]];
        NSDictionary *snapshotPhotos = snapshot.value[@"photos"];
        NSMutableArray *photosInitialLoadTasks = @[].mutableCopy;
        [snapshotPhotos enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            BFTaskCompletionSource *photoTaskSource = nil;
            if (taskSource && !taskSource.task.completed) {
                photoTaskSource = [BFTaskCompletionSource taskCompletionSource];
                [photosInitialLoadTasks addObject:photoTaskSource.task];
            }
            Firebase *photoRef = [[[ref root] childByAppendingPath:@"photos"] childByAppendingPath:key];
            Photo *photo = [Photo photoFromRef:photoRef inPost:post withInitialLoadTaskSource:photoTaskSource];
            [post.photos addObject:photo];
        }];
        if (taskSource && !taskSource.task.completed) {
            [[BFTask taskForCompletionOfAllTasks:photosInitialLoadTasks] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
                [post.photos sortUsingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
                    return [p2.timestamp compare:p1.timestamp];
                }];
                [taskSource trySetResult:@YES];
                return nil;
            }];
        } else {
            [post.photos sortUsingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
                return [p2.timestamp compare:p1.timestamp];
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:EPICPostDidUpdatePhotosNotification
                                                                object:self];
        }
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
