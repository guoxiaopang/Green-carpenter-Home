//
//  QJAddDataManager.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddDataManager.h"
#import "YYModel.h"

@interface QJAddDataManager()

@property (nonatomic, strong) NSMutableArray *leftItem;
@property (nonatomic, strong) NSMutableArray *rightItem;
@property (nonatomic, strong) NSMutableArray *saleArray;

@end

@implementation QJAddDataManager

#pragma mark - left

- (NSMutableArray *)leftItem
{
    if (!_leftItem)
    {
        _leftItem = [NSMutableArray array];
        [_leftItem addObjectsFromArray:@[@"青年川味香辣饭", @"青年逼格饭", @"辣些逼格饭", @"青春正浓青饮正夏", @"青年卤力饭", @"青春时光小吃"]];
    }
    return _leftItem;
}

- (NSInteger)numOfleft
{
    return self.leftItem.count;
}

- (NSString *)leftWithIndex:(NSInteger)index
{
    if (index < self.leftItem.count)
    {
        return self.leftItem[index];
    }
    return nil;
}

#pragma mark - right
- (NSMutableArray *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dishes" ofType:@"PLIST"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for ( NSArray *itemArray in array)
        {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in itemArray)
            {
                QJMenuModel *model = [QJMenuModel yy_modelWithDictionary:dict];
                [tempArray addObject:model];
            }
            [_rightItem addObject:tempArray];
        }
                                         
    }
    return _rightItem;
}

- (NSInteger)numOfRight:(NSInteger)leftIndex
{
    if (leftIndex < self.rightItem.count)
    {
        NSArray *array = self.rightItem[leftIndex];
        return array.count;
    }
    return 0;
}

- (QJMenuModel *)modelWithIndex:(NSInteger)index leftNumber:(NSInteger)leftIndex
{
    if (leftIndex < self.rightItem.count)
    {
        NSArray *array = self.rightItem[leftIndex];
        if (index < array.count)
        {
            return array[index];
        }
    }
    return nil;
}

// 修改单子数量
- (void)changeModelNum:(QJMenuModel *)model number:(NSString *)number
{
    for (NSArray *array in self.rightItem)
    {
        for (QJMenuModel *oldModel in array)
        {
            if ([model.id isEqualToString:oldModel.id])
            {   // 这里一定会有相等的
                model.num = number;
                [self addModel:model];// 添加进购物车
                return;
            }
        }
        
    }
}

// 专门用数组保存值
- (NSMutableArray *)saleArray
{
    if (!_saleArray)
    {
        _saleArray = [NSMutableArray array];
    }
    return _saleArray;
}

- (void)addModel:(QJMenuModel *)model
{
    for (QJMenuModel *inModel in self.saleArray)
    {
        if ([inModel.id isEqualToString:model.id])
        {
            // 里面已经存在 而且有相等的
            inModel.num = model.num;
            return;
        }
    }
    //执行到这里 说明里面没有相等的 有可能为空
    [self.saleArray addObject:model];
}
@end
