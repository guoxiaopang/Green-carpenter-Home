//
//  QJAddOrderViewController.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddOrderViewController.h"
#import "UIColor+QJColorHEX.h"
#import "QJAddressTableViewCell.h"
#import "QJAddressSelectedViewController.h"

static NSString *QJAddOrderViewControllerIdent = @"QJAddOrderViewControllerIdent";
static NSString *QJAddressTableViewCellIdent = @"QJAddressTableViewCellIdent";
@interface QJAddOrderViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation QJAddOrderViewController
{
    NSString *_address;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"青匠之家";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTableView];
}

#pragma mark - 懒加载
- (void)setTableView
{
    self.tableView.frame = self.view.bounds;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:QJAddOrderViewControllerIdent];
    [self.tableView registerClass:[QJAddressTableViewCell class] forCellReuseIdentifier:QJAddressTableViewCellIdent];
    self.tableView.backgroundColor = [UIColor colorWithHex:0XE6E6E6];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            QJAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QJAddressTableViewCellIdent];
            [cell changeLabelValue:_address];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QJAddOrderViewControllerIdent];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row ==0)
    {
        QJAddressSelectedViewController *controller = [[QJAddressSelectedViewController alloc] init];
        controller.str = ^(NSString *str)
        {
            NSLog(@"%@",str); //拿到地址后 赋值给cell
            _address = str;
            [tableView reloadData];
        };
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
