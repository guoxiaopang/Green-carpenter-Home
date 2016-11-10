//
//  QJOrderTitleView.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const orderYes;
extern NSString *const orderNO;

@interface QJOrderTitleView : UIView

//时间
@property (nonatomic, strong) NSString *time;

// 门店
@property (nonatomic, strong) NSString *shopName;

//订单状态
@property (nonatomic, strong) NSString *orderState;

@end
