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
    return [self systemFontOfSize:size];
}

+ (instancetype)epicLightFontOfSize:(CGFloat)size {
    return [self systemFontOfSize:size weight:UIFontWeightLight];
}
+ (instancetype)epicBoldFontOfSize:(CGFloat)size {
    return [self boldSystemFontOfSize:size];
}

@end
