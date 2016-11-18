//
//  QJSearchDatamanager.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/16.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QJOrderListModel.h"

@class QJSearchDatamanager;
@protocol QJSearchDatamanagerDelegate <NSObject>

- (void)requestSuccessfull:(QJSearchDatamanager *)manager;
- (void)requestFaild:(QJSearchDatamanager *)manager;

@end

@interface QJSearchDatamanager : NSObject

@property (nonatomic, weak) id<QJSearchDatamanagerDelegate> delegate;
/// 返回个数
- (NSInteger)numOfItem;
///  返回model
- (QJOrderListModel *)modelWithIndex:(NSInteger)index;

- (void)requestData:(NSString *)str;


/// 取消订单
- (void)cancelOrdersWithNumber:(NSString *)numberStr;
/// 接单
- (void)receiveOrderWithNumber:(NSString *)numberStr;

@end
