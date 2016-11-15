//
//  QJAddBottomView.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJAddBottomView;
@protocol QJAddBottomViewDelegate <NSObject>

- (void)pushController:(QJAddBottomView *)view;

@end

@interface QJAddBottomView : UIView

@property (nonatomic, weak)id<QJAddBottomViewDelegate> delegate;

@end
