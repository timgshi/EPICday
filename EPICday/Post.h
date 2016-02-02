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

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, strong) NSDate *timestamp;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) Firebase *ref;

+ (NSArray *)postsFromSnapshot:(FDataSnapshot *)snapshot;
+ (instancetype)postFromRef:(Firebase *)ref;

@end
