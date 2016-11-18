//
//  QJAddOrderDatamanager.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/18.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddOrderDatamanager.h"
#import "AFNetworking.h"

@interface QJAddOrderDatamanager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation QJAddOrderDatamanager

- (void)submitOrderPrice:(NSString *)priceStr expected_fetch_time:(NSString *)time receiver_name:(NSString *)name receiver_address:(NSString *)address receiver_phone:(NSString *)phone receiver_tel:(NSString *)tel receiver_lat:(NSString *)lat receiver_lng:(NSString *)lng content:(NSArray *)content
{
    NSString *urlStr = @"http://43.227.98.248:8080/ssm/order/submit";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"cargo_price"] = priceStr;
    param[@"expected_fetch_time"] = time;
    param[@"receiver_name"] = name;
    param[@"receiver_address"] = address;
    param[@"receiver_phone"] = phone;
    param[@"receiver_tel"] = tel;
    param[@"receiver_lat"] = lat;
    param[@"receiver_lng"] = lng;
    param[@"menuList"] = content;
    param[@"city_code"] = @"22";
    
    [self.manager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([self.delegate respondsToSelector:@selector(requestSuccessfull:)])
        {
            [self.delegate requestSuccessfull:self];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if ([self.delegate respondsToSelector:@selector(requestFaild:)])
        {
            [self.delegate requestFaild:self];
        }
    }];
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer=[AFJSONRequestSerializer serializer];// 申明请求数据是json
    }
    return _manager;
}

@end
