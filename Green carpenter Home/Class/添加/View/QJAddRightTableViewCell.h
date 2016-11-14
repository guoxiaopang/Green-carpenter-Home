//
//  QJAddRightTableViewCell.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJMenuModel.h"

@class QJAddRightTableViewCell;
@protocol QJAddRightTableViewCellDelegate <NSObject>

- (void)saveDate:(QJAddRightTableViewCell *)view number:(NSString *)index;

@end

@interface QJAddRightTableViewCell : UITableViewCell

@property (nonatomic, weak)id<QJAddRightTableViewCellDelegate> delegate;
@property (nonatomic, strong) QJMenuModel *model;
- (void)reloadWithModel:(QJMenuModel *)model;

@end
