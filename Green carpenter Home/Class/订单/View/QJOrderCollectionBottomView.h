//
//  QJOrderCollectionBottomView.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJOrderCollectionBottomView;
@protocol QJOrderCollectionBottomViewDelegate <NSObject>

/// 拨打电话
- (void)callPhone:(QJOrderCollectionBottomView *)view;
/// 接单操作
- (void)orders:(QJOrderCollectionBottomView *)view;
/// 打印操作
- (void)printData:(QJOrderCollectionBottomView *)view;
/// 取消订单
- (void)cancelOrder:(QJOrderCollectionBottomView *)view;

@end

@interface QJOrderCollectionBottomView : UIView

@property (nonatomic, weak) id<QJOrderCollectionBottomViewDelegate>delegate;

- (void)setPrint:(NSInteger)index;

@end
