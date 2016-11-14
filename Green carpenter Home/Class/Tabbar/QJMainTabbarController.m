//
//  QJMainTabbarController.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJMainTabbarController.h"
#import "QJMyViewController.h"
#import "QJOrderViewController.h"
#import "QJNavigationController.h"
#import "QJSearchViewController.h"
#import "QJAddViewController.h"

@interface QJMainTabbarController ()

@end

@implementation QJMainTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addController];
}

- (void)addController
{
    [self addController:[[QJOrderViewController alloc] init] title:@"订单" imageName:@"order" seletedImage:@"orderSelected"];
    [self addController:[[QJAddViewController alloc] init] title:@"添加" imageName:@"add" seletedImage:@"addSelected"];
    [self addController:[[QJSearchViewController alloc] init] title:@"搜索" imageName:@"search" seletedImage:@"searchSelected"];
    [self addController:[[QJMyViewController alloc] init] title:@"我的" imageName:@"mine" seletedImage:@"mineSelected"];
    
}

- (void)addController:(UIViewController *) controller title:(NSString *) title imageName:(NSString *)image seletedImage:(NSString *) seletedImage
{
    QJNavigationController *nav = [[QJNavigationController alloc] initWithRootViewController:controller];
    
    controller.tabBarItem.title = title;
    
    controller.tabBarItem.image = [UIImage imageNamed:image];
    
    controller.tabBarItem.selectedImage = [UIImage imageNamed:seletedImage];
    
    [self addChildViewController:nav];
}

@end
