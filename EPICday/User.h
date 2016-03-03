//
//  User.h
//  EPICday
//
//  Created by Tim on 2/3/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Firebase;
@class BFTask;

@interface User : NSObject

@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, readonly) NSString *objectId;
@property (nonatomic, strong) Firebase *ref;

+ (instancetype)userFromRef:(Firebase *)ref;
+ (BFTask *)asyncUserFromRef:(Firebase *)ref;

@end
