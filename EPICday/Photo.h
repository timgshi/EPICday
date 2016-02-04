//
//  Photo.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <Parse/Parse.h>

#import "Channel.h"
#import "Post.h"

@class Firebase;

@interface Photo : NSObject

@property (nonatomic, readonly) NSString *objectId;
@property (nonatomic, strong) Channel *channel;
@property (nonatomic, strong) Post *post;
@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSDictionary *dimensions;
@property (nonatomic, strong) NSURL *imageUrl;
//@property (nonatomic, strong) PFUser *user;
//@property (nonatomic, strong) PFGeoPoint *location;
//@property (nonatomic, strong) NSArray *robbers;

@property (nonatomic, readonly) CGSize size;

@property (nonatomic, strong) Firebase *ref;

+ (instancetype)photoFromRef:(Firebase *)ref inPost:(Post *)post;

@end
