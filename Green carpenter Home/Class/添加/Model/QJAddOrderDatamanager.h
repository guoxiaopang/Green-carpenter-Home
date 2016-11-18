//
//  QJAddOrderDatamanager.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/18.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QJAddOrderDatamanager;
@protocol QJAddOrderDatamanagerDelegate <NSObject>

- (void)requestSuccessfull:(QJAddOrderDatamanager *)manager;
- (void)requestFaild:(QJAddOrderDatamanager *)manager;

@end

@interface QJAddOrderDatamanager : NSObject

@property (nonatomic, weak)id<QJAddOrderDatamanagerDelegate> delegate;
/// 下单
- (void)submitOrderPrice:(NSString *)priceStr expected_fetch_time:(NSString *)time receiver_name:(NSString *)name receiver_address:(NSString *)address receiver_phone:(NSString *)phone receiver_tel:(NSString *)tel receiver_lat:(NSString *)lat receiver_lng:(NSString *)lng content:(NSArray *)content;

@end
