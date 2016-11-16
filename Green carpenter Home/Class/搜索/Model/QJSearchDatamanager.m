//
//  QJSearchDatamanager.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/16.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJSearchDatamanager.h"
#import "AFNetworking.h"
#import "YYModel.h"

@interface QJSearchDatamanager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *item;

@end

@implementation QJSearchDatamanager

- (void)requestData:(NSString *)str
{
//order_id:订单编号(非必填)
//receiver_phone:收货人手机号码(非必填)
//receiver_name:收货人姓名(非必填)
    NSDictionary *param;
    if (str.length == 11 && ([str integerValue] > 10000000000))
    {
        // 电话
        param = @{@"receiver_phone" : str};
    }
    else
    {
        param = @{@"receiver_name" : str};
    }
    
    NSString *strUrl = @"http://43.227.98.248:8080/ssm/order/list";
    
 
    [self.manager GET:strUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"result"];
        if ([array isKindOfClass:[NSArray class]])
        {
            [self.item removeAllObjects];
            for (NSDictionary *dict in array)
            {
                QJOrderListModel *model = [QJOrderListModel yy_modelWithDictionary:dict];
                [self.item addObject:model];
            }
        }
        if ([self.delegate respondsToSelector:@selector(requestSuccessfull:)])
        {
            [self.delegate requestSuccessfull:self];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
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
    }
    return _manager;
}

- (NSMutableArray *)item
{
    if (!_item)
    {
        _item = [NSMutableArray array];
    }
    return _item;
}

- (NSInteger)numOfItem
{
    return self.item.count;
}

- (QJOrderListModel *)modelWithIndex:(NSInteger)index
{
    if (index < self.item.count)
    {
        return self.item[index];
    }
    return nil;
}
@end
