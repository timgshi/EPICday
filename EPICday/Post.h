//
//  Post.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Channel.h"

@class FDataSnapshot;
@class Firebase;

@interface Post : NSObject

@property (nonatomic, readonly) NSString *objectId;
@property (nonatomic, strong) NSDate *timestamp;

@property (nonatomic, strong) NSMutableOrderedSet *photos;

@property (nonatomic, strong) Firebase *ref;

@property (nonatomic, strong) Channel *channel;

+ (NSArray *)postsFromSnapshot:(FDataSnapshot *)snapshot;
+ (instancetype)postFromRef:(Firebase *)ref;

@end
