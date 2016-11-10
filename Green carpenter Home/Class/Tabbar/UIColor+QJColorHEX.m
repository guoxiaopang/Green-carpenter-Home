//
//  UIColor+QJColorHEX.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "UIColor+QJColorHEX.h"

@implementation UIColor (QJColorHEX)

+ (UIColor *)colorWithHex:(NSInteger)color
{
    return [self colorWithHex:color alpha:1];
}

+ (UIColor *)colorWithHex:(NSInteger)color alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((color & 0XFF0000)>>16)/255.0 green:((color & 0X00FF00) >>8)/255.0 blue:(color & 0X0000FF)/255.0 alpha:alpha];
}

@end
