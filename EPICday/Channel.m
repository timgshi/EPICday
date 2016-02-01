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

#import <Parse/PFObject+Subclass.h>

@implementation Channel

@dynamic name;
@dynamic members;
@dynamic avatar;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Channel";
}

- (BFTask *)getRecentPostsAndPhotos {
    PFQuery *postQuery = [Post query];
    [postQuery whereKey:@"channel" equalTo:self];
    [postQuery orderByDescending:@"createdAt"];
    PFQuery *photoQuery = [Photo query];
    [photoQuery includeKey:@"post"];
    [photoQuery whereKey:@"post" matchesQuery:postQuery];
    return [[photoQuery findObjectsInBackground] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        NSArray *photos = task.result;
        NSMutableOrderedSet *postsSet = [NSMutableOrderedSet orderedSet];
        NSMutableDictionary *postsDict = @{}.mutableCopy;
        for (Photo *photo in photos) {
            [postsSet addObject:photo.post];
            NSMutableArray *postPhotoArray = postsDict[photo.post.objectId];
            if (!postPhotoArray) {
                postPhotoArray = @[].mutableCopy;
            }
            [postPhotoArray addObject:photo];
            postsDict[photo.post.objectId] = postPhotoArray;
        }
        for (Post *post in postsSet) {
            post.photos = postsDict[post.objectId];
            [post.photos sortUsingComparator:^NSComparisonResult(Photo *p1, Photo *p2) {
                return [p1.originalTimestamp compare:p2.originalTimestamp];
            }];
        }
        NSArray *postsArray = [postsSet sortedArrayUsingComparator:^NSComparisonResult(Post *p1, Post *p2) {
            return [p1.createdAt compare:p2.createdAt];
        }];
        return [BFTask taskWithResult:postsArray];
    }];
}

@end
