//
//  QJAddBottomView.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddBottomView.h"
#import "Masonry.h"
#import "UIColor+QJColorHEX.h"

@interface QJAddBottomView()

@property (nonatomic, strong) UILabel *totalPrice;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation QJAddBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.totalPrice];
        [self addSubview:self.lineView];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UILabel *)totalPrice
{
    if (!_totalPrice)
    {
        _totalPrice = [[UILabel alloc] init];
        _totalPrice.text = @"￥100";
        _totalPrice.textColor = [UIColor redColor];
    }
    return _totalPrice;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHex:0XEEEEEE];
    }
    return _lineView;
}

- (void)addLayout
{
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@100);
        make.height.equalTo(@(30));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.top.equalTo(self);
    }];
}

#warning 写监听通知
#warning 结算的时候 还有优惠信息
@end
