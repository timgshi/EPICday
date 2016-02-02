//
//  ChannelStreamCollectionViewController.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Channel.h"

@class Firebase;

@interface ChannelStreamCollectionViewController : UICollectionViewController

@property (nonatomic, readonly) Firebase *channelRef;

+ (instancetype)streamCollectionVCForChannelRef:(Firebase *)channelRef;

@end
