//
//  QJOrderDataManager.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJOrderDataManager.h"
#import "AFNetworking.h"
#import "YYModel.h"


@interface QJOrderDataManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *item;

@end

@implementation QJOrderDataManager


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

- (void)requestDataWithStatu:(NSInteger)index
{
    NSString *status;
    if (index == 0)
    {
        // 全部订单
    }
    else if(index == 1)
    {
        // 已接单
        status = @"1";
    }
    else if(index == 2)
    {
       // 待接单
        status = @"0";
    }
 
    NSString *str = @"http://43.227.98.248:8080/ssm/order/list";
    NSDictionary *para;
    if (status.length)
    {
        para = @{@"status" : status};
    }

    [self.manager GET:str parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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


@end
