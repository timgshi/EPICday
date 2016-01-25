//
//  Post.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <Parse/Parse.h>

#import "Channel.h"

@interface Post : PFObject <PFSubclassing>

@property (nonatomic, strong) Channel *channel;
@property (nonatomic, strong) PFUser *user;

@end
