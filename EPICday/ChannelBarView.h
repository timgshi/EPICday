//
//  ChannelBarView.h
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Channel.h"

@interface ChannelBarView : UIView

+ (instancetype)barViewWithChannel:(Channel *)channel;

@end