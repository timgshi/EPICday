//
//  ChannelBarView.h
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Channel.h"

@class Firebase;

@interface ChannelBarView : UIView

+ (instancetype)barViewWithChannelRef:(Firebase *)channelRef;

@end
