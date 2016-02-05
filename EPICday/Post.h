//
//  Post.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Channel.h"

extern NSString * const EPICPostDidUpdatePhotosNotification;

@class BFTask;
@class BFTaskCompletionSource;
@class FDataSnapshot;
@class Firebase;

@interface Post : NSObject

@property (nonatomic, readonly) NSString *objectId;
@property (nonatomic, strong) NSDate *timestamp;

@property (nonatomic, strong) NSMutableOrderedSet *photos;

@property (nonatomic, strong) Firebase *ref;

@property (nonatomic, strong) Channel *channel;

@property (nonatomic, strong) Firebase *userRef;

+ (instancetype)postFromRef:(Firebase *)ref inChannel:(Channel *)channel withInitialLoadTaskSource:(BFTaskCompletionSource *)taskSource;
+ (BFTask *)postFromRef:(Firebase *)ref inChannel:(Channel *)channel;

@end
