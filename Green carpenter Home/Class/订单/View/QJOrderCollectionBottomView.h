//
//  QJOrderCollectionBottomView.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJOrderCollectionBottomView;
@protocol QJOrderCollectionBottomViewDelegate <NSObject>

- (void)callPhone:(QJOrderCollectionBottomView *)view;

@end

@interface QJOrderCollectionBottomView : UIView

@property (nonatomic, weak) id<QJOrderCollectionBottomViewDelegate>delegate;

@end
