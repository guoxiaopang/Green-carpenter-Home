//
//  QJOrderListModel.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJOrderListModel : NSObject
/// 订单金额
@property (nonatomic, assign) double cargo_price;
/// 收货人纬度
@property (nonatomic, assign) double receiver_lat;
/// 收货人经度
@property (nonatomic, assign) double receiver_lng;
/// 主键 这里似乎没有用
@property (nonatomic, assign) NSInteger id;
/// 下单时间
@property (nonatomic, assign) long create_time;
/// 收货人名字
@property (nonatomic, strong) NSString *receiver_name;
/// 收货人地址
@property (nonatomic, strong) NSString *receiver_address;
/// 期望取货时间
@property (nonatomic, assign) long expected_fetch_time;
/// 收货人手机号
@property (nonatomic, strong) NSString *receiver_phone;
/// 订单编号
@property (nonatomic, strong) NSString *order_id;
/// 收货人座机号
@property (nonatomic, strong) NSString *receiver_tel;
/// 订单状态 0待接单 1已接单 -1已取消 2待评价 3已完成
@property (nonatomic, assign) NSInteger status;

/*
/order/list接口
1. 居然没有订单内容 不知道客户到底买什么东西了 需要什么东西
订单内容应该要有名字,数量，比如 牛肉面2份  杂酱面3份
 
2. 订单列表应该只显示今天的数据
 
3. 应该要由订单备注。比如少要一点辣椒
 
4. 没有返回达达状态。商家并不知道达达运送的状态。 这里应该会用到那个回调。 状态改变了 通知你的那个
5. 没有返回头像地址。这个忙的话暂时就不用返回了
6. 订单号太小，会重复。 可以在前面加日期 比如 20161115000000

7. 没有商家接单这个接口。 商家接单后，才向达达发送订单。
8. 商家取消订单 接口请求失败.地址参数如下
http://43.227.98.248:8080/ssm/order/cancel/saler?order_id=1002&cancel_reason_id=123"

*/

@end
