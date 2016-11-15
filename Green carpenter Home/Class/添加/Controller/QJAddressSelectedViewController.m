//
//  QJAddressSelectedViewController.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddressSelectedViewController.h"
#import "QJAddressSelectedTableViewCell.h"

@interface QJAddressSelectedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QJAddressSelectedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[QJAddressSelectedTableViewCell class] forCellReuseIdentifier:@"aa"];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 60;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.sectionFooterHeight = 5.0f;
        _tableView.sectionHeaderHeight = 5.0f;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QJAddressSelectedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
    if (indexPath.section == 0)
    {
        cell.textField.placeholder = @"请输入姓名";
    }
    else if(indexPath.section == 1)
    {
        cell.textField.placeholder = @"请输入电话";
    }
    else
    {
        cell.textField.placeholder = @"请输入地址";
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc
{
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < 3; i++)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:i];
        QJAddressSelectedTableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
        [str appendString:cell.textField.text];
        if (i != 2) {
            [str appendString:@"\n"];
        }
    }
    self.str(str);
   
}


@end
