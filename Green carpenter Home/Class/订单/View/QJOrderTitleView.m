//
//  QJOrderTitleView.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJOrderTitleView.h"
#import "Masonry.h"
#import "UIColor+QJColorHEX.h"

NSString *const orderYes = @"已接单";
NSString *const orderNO = @"未接单";

@interface QJOrderTitleView()

@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) UIButton *shopNameButton;
@property (nonatomic, strong) UIButton *orderStateButton;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation QJOrderTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.timeButton];
        [self addSubview:self.shopNameButton];
        [self addSubview:self.orderStateButton];
        [self addSubview:self.lineView];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHex:0xececec];
    }
    return _lineView;
}

- (UIButton *)timeButton
{
    if (!_timeButton)
    {
        _timeButton = [[UIButton alloc] init];
        [_timeButton setTitle:[self currDate] forState:UIControlStateNormal];
        [_timeButton setTitleColor:[UIColor colorWithHex:0X353535] forState:UIControlStateNormal];
        _timeButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_timeButton setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
        [_timeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 65, 0, -65)];
        [_timeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 25)];
        [_timeButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _timeButton.tag = 0;
        _time = [self currDate];
    }
    return _timeButton;
}

- (UIButton *)shopNameButton
{
    if (!_shopNameButton)
    {
        _shopNameButton = [[UIButton alloc] init];
        [_shopNameButton setTitle:@"默认门店" forState:UIControlStateNormal];
        _shopNameButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_shopNameButton setTitleColor:[UIColor colorWithHex:0X353535] forState:UIControlStateNormal];
        [_shopNameButton setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
        [_shopNameButton setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, -70)];
        [_shopNameButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
        [_timeButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _shopNameButton.tag = 1;
    }
    return _shopNameButton;
}

- (UIButton *)orderStateButton
{
    if (!_orderStateButton)
    {
        _orderStateButton = [[UIButton alloc] init];
        [_orderStateButton setTitle:orderNO forState:UIControlStateNormal];
        _orderStateButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_orderStateButton setTitleColor:[UIColor colorWithHex:0X353535] forState:UIControlStateNormal];
        [_orderStateButton setImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
        [_orderStateButton setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, -60)];
        [_orderStateButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [_orderStateButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _orderState = orderNO;
        _orderStateButton.tag = 2;
    }
    return _orderStateButton;
}

#pragma mark - Void
- (void)addLayout
{
    [_timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(100));
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
    }];
    
    [_shopNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_orderStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(100));
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(2));
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

- (NSString *)currDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yy-MM-dd";
    return  [fmt stringFromDate:date];
}

- (void)clickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(clickButton:index:)])
    {
        [self.delegate clickButton:self index:button.tag];
    }
}


@end
