
//
//  QJOrderCollectionBottomView.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJOrderCollectionBottomView.h"
#import "Masonry.h"
#import "UIColor+QJColorHEX.h"

@interface QJOrderCollectionBottomView()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *callButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *orderButton;

@end

@implementation QJOrderCollectionBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.callButton];
        [self addSubview:self.lineView];
        [self addSubview:self.cancelButton];
        [self addSubview:self.orderButton];
        [self addLayout];
    }
    return self;
}

#pragma mark - Void 

- (UIButton *)orderButton
{
    if (!_orderButton)
    {
        _orderButton = [[UIButton alloc] init];
        [_orderButton setTitle:@"接单" forState:UIControlStateNormal];
        _orderButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_orderButton setBackgroundImage:[self imageWithColor:[UIColor colorWithHex:0x32CD32]] forState:UIControlStateNormal];
        _orderButton.layer.cornerRadius = 8.0f;
        _orderButton.clipsToBounds = YES;
    }
    return _orderButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelButton setBackgroundImage:[self imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        _cancelButton.layer.cornerRadius = 8.0f;
        _cancelButton.clipsToBounds = YES;
    }
    return _cancelButton;
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

- (UIButton *)callButton
{
    if (!_callButton)
    {
        _callButton = [[UIButton alloc] init];
        [_callButton setTitle:@"拨打电话" forState:UIControlStateNormal];
        [_callButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _callButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_callButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_callButton setBackgroundImage:[self imageWithColor:[UIColor colorWithHex:0XEEEEEE]] forState:UIControlStateHighlighted];
        _callButton.layer.cornerRadius = 8.0f;
        _callButton.clipsToBounds = YES;
        _callButton.layer.borderWidth = 0.5f;
        [_callButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callButton;
}

- (void)addLayout
{
    [_callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(14);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@80);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.right.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@80);
    }];
    
    [_orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-14);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@80);
    }];
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

- (void)callPhone
{
    if ([self.delegate respondsToSelector:@selector(callPhone:)])
    {
        [self.delegate callPhone:self];
    }
}

@end
