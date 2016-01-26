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

@interface Photo : PFObject <PFSubclassing>

@property (nonatomic, strong) Channel *channel;
@property (nonatomic, strong) Post *post;
@property (nonatomic, strong) NSDate *originalTimestamp;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) NSDictionary *dimensions;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) NSArray *robbers;
@property (nonatomic, strong) PFFile *image;

@property (nonatomic, readonly) CGSize size;

@end
