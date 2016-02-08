//
//  UIFont+EPIC.m
//  EPICday
//
//  Created by Tim on 1/26/16.
//  Copyright © 2016 Epicurrence. All rights reserved.
//

#import "UIFont+EPIC.h"

@implementation UIFont (EPIC)

+ (instancetype)epicDefaultFontOfSize:(CGFloat)size {
    return [self fontWithName:@"FuturaBT-Book" size:size];
}

+ (instancetype)epicLightFontOfSize:(CGFloat)size {
    return [self fontWithName:@"FuturaBT-Book" size:size];
}

+ (instancetype)epicBoldFontOfSize:(CGFloat)size {
    return [self fontWithName:@"FuturaBT-Heavy" size:size];
}

@end
