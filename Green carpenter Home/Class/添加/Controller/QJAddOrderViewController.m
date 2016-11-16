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
#import "QJTimeTableViewCell.h"
#import "QJTimePickerView.h"
#import "QJInfoTableViewCell.h"
#import "QJAddOrderBottomView.h"
#import "Masonry.h"

static NSString *QJAddOrderViewControllerIdent = @"QJAddOrderViewControllerIdent";
static NSString *QJAddressTableViewCellIdent = @"QJAddressTableViewCellIdent";
static NSString *QJTimeTableViewCellIdent = @"QJTimeTableViewCellIdent";
static NSString *QJInfoTableViewCellIdent = @"QJInfoTableViewCellIdent";

@interface QJAddOrderViewController ()<UITableViewDelegate, UITableViewDataSource, QJAddOrderBottomViewDelegate>

@property (nonatomic, strong) QJTimePickerView *timePickerView;
@property (nonatomic, strong) QJAddOrderBottomView *bottomView;

@end

@implementation QJAddOrderViewController
{
    NSString *_address;
    NSString *_phoneNumber;
    NSString *_name;
    NSString *_time;
    NSArray *_foodArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"青匠之家";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTableView];
    [self.tableView addSubview:self.bottomView];
}

#pragma mark - 懒加载
- (QJAddOrderBottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[QJAddOrderBottomView alloc] init];
        _bottomView.delegate = self;
        _bottomView.frame = CGRectMake(0, CGRectGetHeight(self.tableView.frame) - 44 - 44, CGRectGetWidth(self.view.frame), 44);
    }
    return _bottomView;
}

- (QJTimePickerView *)timePickerView
{
    if (!_timePickerView)
    {
        _timePickerView = [[QJTimePickerView alloc] init];
        __weak typeof(self) weakSelf = self;
        _timePickerView.str = ^(NSString *str)
        {
            _time = str;
            [weakSelf.tableView reloadData];
        };
    }
    return _timePickerView;
}

- (void)setTableView
{
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:QJAddOrderViewControllerIdent];
    [self.tableView registerClass:[QJAddressTableViewCell class] forCellReuseIdentifier:QJAddressTableViewCellIdent];
    [self.tableView registerClass:[QJTimeTableViewCell class] forCellReuseIdentifier:QJTimeTableViewCellIdent];
    [self.tableView registerClass:[QJInfoTableViewCell class] forCellReuseIdentifier:QJInfoTableViewCellIdent];
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
            if (_name.length || _address.length || _phoneNumber.length)
            {
                [cell changeLabelValue:_name withNumber:_phoneNumber address:_address];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        else
        {
            QJTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QJTimeTableViewCellIdent];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell reloadContent:_time];
            return cell;
        }
    }
    else if (indexPath.section == 1)
    {
        QJInfoTableViewCell *info = [[QJInfoTableViewCell alloc] init];
        return info;
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
        controller.str = ^(NSString *name , NSString *phoneNumber, NSString *address)
        {//拿到地址后 赋值给cell
            _name = name;
            _phoneNumber = phoneNumber;
            _address = address;
            [tableView reloadData];
        };
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        [self.timePickerView show];
    }
}

#pragma mark - QJAddOrderBottomViewDelegate
- (void)determineCommit
{
    //订单金额 cargo_price
    //期望取货时间 expected_fetch_time
    //收货人姓名 receiver_name
    //收货人地址 receiver_address
    //收货人手机号 receiver_phone || receiver_tel
    //纬度   receiver_lat
    //经度   receiver_lng
}


- (void)foodArray:(NSArray *)foodArray
{
    // 订餐数组
    NSLog(@"%@",foodArray);
    _foodArray = foodArray;
}


@end
