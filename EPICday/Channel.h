//
//  Channel.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const EPICChannelDidUpdatePostsNotification;

@class BFTaskCompletionSource;
@class Firebase;

@interface Channel : NSObject

@property (nonatomic, readonly) NSString *objectId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, strong) NSMutableOrderedSet *posts;
@property (nonatomic, strong) NSDictionary *membersDict;

@property (nonatomic, strong) Firebase *ref;

+ (instancetype)channelFromRef:(Firebase *)ref withInitialLoadTaskSource:(BFTaskCompletionSource *)taskSource;

@end
