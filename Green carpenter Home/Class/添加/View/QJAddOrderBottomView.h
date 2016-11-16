//
//  QJAddOrderBottomView.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/16.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QJAddOrderBottomViewDelegate <NSObject>

- (void)determineCommit;

@end

@interface QJAddOrderBottomView : UIView

@property(nonatomic, strong) id<QJAddOrderBottomViewDelegate> delegate;

@end
