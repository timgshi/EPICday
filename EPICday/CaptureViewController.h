//
//  CaptureViewController.h
//  EPICday
//
//  Created by Tim on 1/27/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Channel.h"

@class Firebase;

@interface CaptureViewController : UIViewController

@property (nonatomic, strong) Firebase *selectedChannelRef;

@end
