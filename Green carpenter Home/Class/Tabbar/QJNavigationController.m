//
//  QJNavigationController.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJNavigationController.h"
#import "UIColor+QJColorHEX.h"

@interface QJNavigationController ()

@end

@implementation QJNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithHex:0X108ADC];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
