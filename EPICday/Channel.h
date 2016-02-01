//
//  Channel.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Channel : PFObject <PFSubclassing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *members;
@property (nonatomic, strong) PFFile *avatar;

- (BFTask *)getRecentPostsAndPhotos;

@end
