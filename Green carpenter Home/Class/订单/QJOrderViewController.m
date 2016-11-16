//
//  QJOrderViewController.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJOrderViewController.h"
#import "QJOrderTitleView.h"
#import "UIColor+QJColorHEX.h"
#import "QJOrderCollectionViewCell.h"
#import "QJDatePickerView.h"
#import "QJOrderDataManager.h"
#import "QJOrderListModel.h"
#import "MJRefresh.h"

static NSString *QJOrderViewIdent = @"QJOrderViewIdent";

@interface QJOrderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIActionSheetDelegate, QJOrderTitleViewDelegate, QJOrderDataManagerDelegate, QJOrderCollectionViewCellDelegate>

@property (nonatomic, strong) QJOrderTitleView *selectView;
@property (nonatomic, strong) UICollectionView *collectionView;
//时间选择器
@property (nonatomic, strong) QJDatePickerView *datePickerView;
@property (nonatomic, strong) QJOrderDataManager *dataManager;

@end

@implementation QJOrderViewController
{
    NSInteger _currStatus;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self.dataManager requestDataWithStatu:_currStatus];
    }];
    [self.collectionView .mj_header beginRefreshing];
}

#pragma mark - 懒加载
- (QJOrderDataManager *)dataManager
{
    if (!_dataManager)
    {
        _dataManager = [[QJOrderDataManager alloc] init];
        _dataManager.delegate = self;
    }
    return _dataManager;
}

- (QJDatePickerView *)datePickerView
{
    if (!_datePickerView)
    {
        _datePickerView = [[QJDatePickerView alloc] init];
    }
    return _datePickerView;
}

- (QJOrderTitleView *)selectView
{
    if (!_selectView)
    {
        _selectView = [[QJOrderTitleView alloc] init];
        _selectView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44);
        _selectView.delegate = self;
    }
    return _selectView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        CGFloat spaceing = 10.0f;
        CGFloat width = CGRectGetWidth(self.view.frame) - 20.0f;
        CGFloat height = 250.0f;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(spaceing, spaceing, spaceing, spaceing);
        flowLayout.minimumLineSpacing = spaceing;
        flowLayout.minimumInteritemSpacing = spaceing;
        flowLayout.estimatedItemSize = CGSizeMake(width, height);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        CGRect rect = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64 - 49 - 44);
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHex:0xececec];
        [_collectionView registerClass:[QJOrderCollectionViewCell class] forCellWithReuseIdentifier:QJOrderViewIdent];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataManager numOfItem];
}

//返回行
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QJOrderCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:QJOrderViewIdent forIndexPath:indexPath];
    QJOrderListModel *model = [self.dataManager modelWithIndex:indexPath.row];
    cell.delegate = self;
    [cell reloadModel:model];
    return cell;
}

#pragma mark - QJOrderTitleViewDelegate
- (void)clickButton:(QJOrderTitleView *)titleView index:(NSInteger)index
{
    if (index == 0)
    {
        // 时间选择器
        [self pushUIDatePicker];
    }
    else if (index == 1)
    {
        // 门店选择
    }
    else if (index == 2)
    {
        // 订单状态选择
        
        // 弹出一个选择器
        UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:@"请选择订单状态" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部订单", @"已接单", @"未接单", nil];
        [sheetView showInView:self.view];
        
    }
}

#pragma mark - Void
- (void)pushUIDatePicker
{
    [self.datePickerView show];
    __weak typeof(self) weakSelf = self;
    self.datePickerView.str = ^(NSString *str)
    {
        weakSelf.selectView.time = str;
    };
}

- (void)seletedDatePicker:(UIDatePicker *)picker
{

}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _currStatus = buttonIndex;
    // 0 全部订单 1已接单 2.未接单
    [self.selectView setButtonTitle:buttonIndex];
    
    // 加载数据
    [self.dataManager requestDataWithStatu:buttonIndex];
}

#pragma mark - QJOrderDataManagerDelegate
- (void)requestSuccessfull:(QJOrderDataManager *)manager
{
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]]; // 这里有个bug  reloadData会报错
    [self.collectionView.mj_header endRefreshing];
}

- (void)requestFaild:(QJOrderDataManager *)manager
{
    [self.collectionView.mj_header endRefreshing];
}

#pragma mark - QJOrderCollectionViewCell
/// 点击接单
- (void)clickOrder:(QJOrderCollectionViewCell *)cell
{
        NSLog(@"接单");
}
/// 点击取消订单
- (void)cancelOrder:(QJOrderCollectionViewCell *)cell
{
        NSLog(@"取消订单");
}

@end
