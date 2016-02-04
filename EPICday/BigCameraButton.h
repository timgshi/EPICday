//
//  BigCameraButton.h
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigCameraButton : UIButton

@property (nonatomic) BOOL showsCameraIcon;

+ (instancetype)button;
- (void)animateToStopButton;
- (void)animateToRecordButton;

@end
