//
//  QJDatePickerView.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dateString)(NSString *str);

@interface QJDatePickerView : UIView

- (void)show;

@property (nonatomic, copy) dateString str;

@end
