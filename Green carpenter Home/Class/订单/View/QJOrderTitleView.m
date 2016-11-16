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
NSString *const orderAll = @"全部订单";

@interface QJOrderTitleView()

@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) UIImageView *timeImageView;
@property (nonatomic, strong) UIButton *shopNameButton;
@property (nonatomic, strong) UIImageView *shopImageView;
@property (nonatomic, strong) UIButton *orderStateButton;
@property (nonatomic, strong) UIImageView *orderImageView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation QJOrderTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.timeButton];
        [self addSubview:self.timeImageView];
        [self addSubview:self.shopNameButton];
        [self addSubview:self.orderStateButton];
        [self addSubview:self.shopImageView];
        [self addSubview:self.orderImageView];
        [self addSubview:self.lineView];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)orderImageView
{
    if (!_orderImageView)
    {
        _orderImageView = [[UIImageView alloc] init];
        _orderImageView.image = [UIImage imageNamed:@"jiantou.png"];

    }
    return _orderImageView;
}
- (UIImageView *)shopImageView
{
    if (!_shopImageView)
    {
        _shopImageView = [[UIImageView alloc] init];
        _shopImageView.image = [UIImage imageNamed:@"jiantou.png"];
    }
    return _shopImageView;
}

- (UIImageView *)timeImageView
{
    if (!_timeImageView)
    {
        _timeImageView = [[UIImageView alloc] init];
        _timeImageView.image = [UIImage imageNamed:@"jiantou.png"];
    }
    return _timeImageView;
}

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
        [_orderStateButton setTitle:orderAll forState:UIControlStateNormal];
        _orderStateButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_orderStateButton setTitleColor:[UIColor colorWithHex:0X353535] forState:UIControlStateNormal];
        [_orderStateButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _orderState = orderAll;
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
    
    [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(8));
        make.left.equalTo(_timeButton.mas_right);
        make.centerY.equalTo(_timeButton);
    }];
    
    [_shopNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(8));
        make.left.equalTo(_shopNameButton.mas_right).offset(3);
        make.centerY.equalTo(_shopNameButton);
    }];
    
    [_orderStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self);
    }];
    
    [_orderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(8));
        make.left.equalTo(_orderStateButton.mas_right).offset(1);
        make.centerY.equalTo(_orderStateButton);
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
    fmt.dateFormat = @"yyyy-MM-dd";
    return  [fmt stringFromDate:date];
}

- (void)clickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(clickButton:index:)])
    {
        [self.delegate clickButton:self index:button.tag];
    }
}

- (void)setTime:(NSString *)time
{
    _time = time;
    [_timeButton setTitle:time forState:UIControlStateNormal];
}

- (void)setButtonTitle:(NSInteger)index
{
    if (index == 0)
    {
        [_orderStateButton setTitle:orderAll forState:UIControlStateNormal];
    }
    else if (index == 1)
    {
        [_orderStateButton setTitle:orderYes forState:UIControlStateNormal];
    }
    else if (index == 2)
    {
         [_orderStateButton setTitle:orderNO forState:UIControlStateNormal];
    }
}


@end
