//
//  UIColor+QJColorHEX.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (QJColorHEX)

+ (UIColor *)colorWithHex:(NSInteger)color;
+ (UIColor *)colorWithHex:(NSInteger)color alpha:(CGFloat)alpha;

@end
