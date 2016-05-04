//
//  Photo.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "Channel.h"

@class BFTask;
@class BFTaskCompletionSource;
@class Firebase;

@interface Photo : NSObject

@property (nonatomic, readonly) NSString *objectId;
@property (nonatomic, strong) Channel *channel;
@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSDictionary *dimensions;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSURL *thumbnailUrl;

@property (nonatomic, readonly) CGSize size;

@property (nonatomic, strong) Firebase *ref;
@property (nonatomic, strong) Firebase *userRef;

+ (instancetype)photoFromRef:(Firebase *)ref inChannel:(Channel *)channel withInitialLoadTaskSource:(BFTaskCompletionSource *)taskSource;
+ (BFTask *)photoFromRef:(Firebase *)ref inChannel:(Channel *)channel;

@end
