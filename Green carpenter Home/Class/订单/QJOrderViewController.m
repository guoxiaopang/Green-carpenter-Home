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

static NSString *QJOrderViewIdent = @"QJOrderViewIdent";

@interface QJOrderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, QJOrderTitleViewDelegate>

@property (nonatomic, strong) QJOrderTitleView *selectView;
@property (nonatomic, strong) UICollectionView *collectionView;
//时间选择器
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation QJOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.collectionView];
}

#pragma mark - 懒加载
- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 200, CGRectGetWidth(self.view.frame), 200);
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
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
    return 1;
}

//返回行
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 19;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QJOrderCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:QJOrderViewIdent forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
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
    else if (index == 3)
    {
        // 订单状态选择
    }
}

#pragma mark - Void
- (void)pushUIDatePicker
{
    [self.view addSubview:self.datePicker];
}

- (void)seletedDatePicker:(UIDatePicker *)picker
{

}

@end
