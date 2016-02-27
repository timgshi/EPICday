//
//  UIColor+EPIC.m
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "UIColor+EPIC.h"

@implementation UIColor (EPIC)

+ (UIColor *)epicDarkGrayColor {
    return [UIColor colorWithRed:0.146 green:0.152 blue:0.167 alpha:1];
}

+ (UIColor *)epicGrayColor {
    return [UIColor colorWithRed:0.167 green:0.167 blue:0.182 alpha:1];
}

+ (UIColor *)epicLightGrayColor {
    return [UIColor colorWithRed:0.292 green:0.302 blue:0.332 alpha:1];
}

+ (UIColor *)epicRedColor {
    return [UIColor colorWithRed:0.768 green:0.23 blue:0.277 alpha:1];
}

+ (UIColor *)epicLightRedColor {
    return [UIColor colorWithRed:0.908 green:0.299 blue:0.351 alpha:1];
}

+ (UIColor *)epicGreenColor {
    return [UIColor colorWithRed:0.298 green:0.586 blue:0.533 alpha:1];
}

- (UIImage *)image {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
