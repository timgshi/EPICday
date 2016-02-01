//
//  UIFont+EPIC.h
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (EPIC)

+ (instancetype)epicDefaultFontOfSize:(CGFloat)size;
+ (instancetype)epicLightFontOfSize:(CGFloat)size;
+ (instancetype)epicBoldFontOfSize:(CGFloat)size;

@end
