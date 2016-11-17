//
//  QJSearchViewController.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJSearchViewController.h"
#import "QJOrderCollectionViewCell.h"
#import "UIColor+QJColorHEX.h"
#import "QJOrderListModel.h"
#import "QJSearchDatamanager.h"

@interface QJSearchViewController ()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, QJOrderCollectionViewCellDelegate, QJSearchDatamanagerDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) QJSearchDatamanager *dataManager;

@end

static NSString *QJSearchViewControllerIdent = @"QJSearchViewControllerIdent";
@implementation QJSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"搜索";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.searchBar];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colseKeyborad)];
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - 懒加载
- (QJSearchDatamanager *)dataManager
{
    if (!_dataManager)
    {
        _dataManager = [[QJSearchDatamanager alloc] init];
        _dataManager.delegate = self;
    }
    return _dataManager;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44.0f);
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.placeholder = @"请输入订单号|电话号码|姓名";
        _searchBar.delegate = self;
    }
    return _searchBar;
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
        
        CGRect rect = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64 - 49 - 44 );
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHex:0xececec];
        [_collectionView registerClass:[QJOrderCollectionViewCell class] forCellWithReuseIdentifier:QJSearchViewControllerIdent];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataManager numOfItem];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QJOrderCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:QJSearchViewControllerIdent forIndexPath:indexPath];
    QJOrderListModel *model = [self.dataManager modelWithIndex:indexPath.row];
    cell.delegate = self;
    [cell reloadModel:model];
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 请求网络搜索
    [self.dataManager requestData:searchBar.text];
}

#pragma mark - QJOrderCollectionViewCell
/// 点击接单
- (void)clickOrder:(QJOrderCollectionViewCell *)cell
{
    NSLog(@"接单");
}
/// 点击取消订单
- (void)cancelOrder:(QJOrderCollectionViewCell *)cell orderNumber:(NSString *)number
{
    NSLog(@"取消订单");
    [self.dataManager cancelOrdersWithNumber:number];
}

#pragma mark - Void
- (void)requestSuccessfull:(QJSearchDatamanager *)manager
{
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [self colseKeyborad];
}

- (void)requestFaild:(QJSearchDatamanager *)manager
{
        
}

#pragma mark - Void
- (void)colseKeyborad
{
    [self.view endEditing:YES];
}

@end
