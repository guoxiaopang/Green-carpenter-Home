//
//  QJOrderViewController.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJOrderViewController.h"
#import "QJOrderTitleView.h"

@interface QJOrderViewController ()

@property (nonatomic, strong) QJOrderTitleView *selectView;

@end

@implementation QJOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.selectView];
}

#pragma mark - 懒加载
- (QJOrderTitleView *)selectView
{
    if (!_selectView)
    {
        _selectView = [[QJOrderTitleView alloc] init];
        _selectView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44);
        _selectView.backgroundColor = [UIColor grayColor];
    }
    return _selectView;
}

@end
