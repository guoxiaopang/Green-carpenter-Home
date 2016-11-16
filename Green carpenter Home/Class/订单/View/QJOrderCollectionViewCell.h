//
//  QJOrderCollectionViewCell.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJOrderListModel.h"

@class QJOrderCollectionViewCell;
@protocol QJOrderCollectionViewCellDelegate <NSObject>

/// 点击接单
- (void)clickOrder:(QJOrderCollectionViewCell *)cell;
/// 点击取消订单
- (void)cancelOrder:(QJOrderCollectionViewCell *)cell;

@end

@interface QJOrderCollectionViewCell : UICollectionViewCell

@property(nonatomic, weak)id<QJOrderCollectionViewCellDelegate> delegate;
- (void)reloadModel:(QJOrderListModel *)model;

@end
