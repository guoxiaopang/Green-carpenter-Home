//
//  QJAddDataManager.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QJMenuModel.h"

@interface QJAddDataManager : NSObject

- (NSInteger)numOfleft;
- (NSString *)leftWithIndex:(NSInteger)index;

- (NSInteger)numOfRight:(NSInteger)leftIndex;
- (QJMenuModel *)modelWithIndex:(NSInteger)index leftNumber:(NSInteger)leftIndex;

// 改变数量
- (void)changeModelNum:(QJMenuModel *)model number:(NSString *)number;

@end
