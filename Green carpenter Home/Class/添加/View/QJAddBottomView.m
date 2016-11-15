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
#import "QJMenuModel.h"
#import "QJAddOrderViewController.h"

@interface QJAddBottomView()

@property (nonatomic, strong) UILabel *totalPrice;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation QJAddBottomView
{
    NSArray *_list;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.totalPrice];
        [self addSubview:self.lineView];
        [self addSubview:self.button];
        [self addSubview:self.countLabel];
        [self addLayout];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"sale" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 懒加载
- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.text = @"0件";
    }
    return _countLabel;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"结算" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.userInteractionEnabled = NO;
        [_button setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)totalPrice
{
    if (!_totalPrice)
    {
        _totalPrice = [[UILabel alloc] init];
        _totalPrice.text = @"￥0.00";
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
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@50);
    }];
}

#warning 结算的时候 还有优惠信息
- (void)change:(NSNotification *)notify
{
    // 拿到数组了 计算价格
    NSArray *array = notify.userInfo[@"list"];
    _list = array;
    double count = 0;
    NSInteger index;
    for (QJMenuModel *model in array)
    {
        count += [model.price floatValue] * [model.num floatValue];
        index += [model.num integerValue];
    }
    _totalPrice.text = [NSString stringWithFormat:@"￥%.2f",count];
    _countLabel.text = [NSString stringWithFormat:@"%ld件", index];

    if (array.count)
    {
        [_button setBackgroundImage:[self imageWithColor:[UIColor colorWithHex:0x32CD32]] forState:UIControlStateNormal];
        _button.userInteractionEnabled = YES;
    }
    else
    {
        [_button setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        _button.userInteractionEnabled = NO;
    }
}

//把颜色转为图片
- (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)click
{
    if ([self.delegate respondsToSelector:@selector(pushController:)])
    {
        [self.delegate pushController:self];
    }
}

@end
