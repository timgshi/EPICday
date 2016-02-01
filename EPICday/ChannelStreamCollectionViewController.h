//
//  ChannelStreamCollectionViewController.h
//  EPICday
//
//  Created by Tim on 1/25/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Channel.h"

@interface ChannelStreamCollectionViewController : UICollectionViewController

@property (nonatomic, readonly) Channel *channel;

+ (instancetype)streamCollectionVCForChannel:(Channel *)channel;

@end
