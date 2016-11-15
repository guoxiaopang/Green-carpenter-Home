//
//  QJAddViewController.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddViewController.h"
#import "QJAddDataManager.h"
#import "QJAddLeftTableViewCell.h"
#import "Masonry.h"
#import "QJMenuModel.h"
#import "QJAddRightTableViewCell.h"
#import "QJAddBottomView.h"
#import "QJAddOrderViewController.h"

static  NSString *QJAddLeftTableViewCellIdent = @"QJAddLeftTableViewCellIdent";
static  NSString *QJAddrightTableViewCellIdent = @"QJAddrightTableViewCellIdent";

@interface QJAddViewController ()<UITableViewDelegate, UITableViewDataSource, QJAddRightTableViewCellDelegate, QJAddBottomViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) QJAddDataManager *dataManager;
@property (nonatomic, strong) QJAddBottomView *bottomView;

@end

@implementation QJAddViewController
{
    NSInteger _selected;
    NSInteger _oldSelected;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"手动下单";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    [self.view addSubview:self.bottomView];
    [self addLayout];
    _selected = 0;
    _oldSelected = 0;
}

#pragma mark - 懒加载
- (QJAddBottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[QJAddBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] init];
        _rightTableView.frame = CGRectMake(100, 0,CGRectGetWidth(self.view.frame) - 100, CGRectGetHeight(self.view.frame));
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [_rightTableView registerClass:[QJAddRightTableViewCell class] forCellReuseIdentifier:QJAddrightTableViewCellIdent];
        _rightTableView.rowHeight = 60;

        _rightTableView.showsHorizontalScrollIndicator = NO;
        _rightTableView.tableFooterView = [[UIView alloc] init];
    }
    return _rightTableView;
}

- (QJAddDataManager *)dataManager
{
    if (!_dataManager)
    {
        _dataManager = [[QJAddDataManager alloc] init];
    }
    return _dataManager;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] init];
        _leftTableView.frame = CGRectMake(0, 0, 100, 300);
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[QJAddLeftTableViewCell class] forCellReuseIdentifier:QJAddLeftTableViewCellIdent];
        _leftTableView.rowHeight = UITableViewAutomaticDimension;
        _leftTableView.estimatedRowHeight = 60;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        _leftTableView.tableFooterView = [[UIView alloc] init];
    }
    return _leftTableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView)
    {
         return [self.dataManager numOfleft];
    }
    else
    {
        return [self.dataManager numOfRight:_selected];
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.leftTableView)
    {
        QJAddLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QJAddLeftTableViewCellIdent];
        [cell reloadData:[self.dataManager leftWithIndex:indexPath.row]];
        if (indexPath.row == _selected)
        {
            [cell seleted:YES];
        }
        else
        {
            [cell seleted:NO];
        }
        return cell;
    }
    else
    {
        QJAddRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QJAddrightTableViewCellIdent];
        cell.delegate = self;
        QJMenuModel *model = [self.dataManager modelWithIndex:indexPath.row leftNumber:_selected];
        [cell reloadWithModel:model];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==  self.leftTableView)
    {
        QJAddLeftTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_oldSelected inSection:0]];
        [cell seleted:NO];
        QJAddLeftTableViewCell *selected = [tableView cellForRowAtIndexPath:indexPath];
        [selected seleted:YES];
        _selected = indexPath.row;
        _oldSelected = _selected;
        [self.rightTableView reloadData];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

    
}

#pragma mark - QJAddRightTableViewCellDelegate
- (void)saveDate:(QJAddRightTableViewCell *)view number:(NSString *)index
{
    //改变值
    [self.dataManager changeModelNum:view.model number:index];
}

#pragma mark - Void
- (void)addLayout
{
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

#pragma mark - QJAddBottomViewDelegate
- (void)pushController:(QJAddBottomView *)view
{
    QJAddOrderViewController *controller = [[QJAddOrderViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
