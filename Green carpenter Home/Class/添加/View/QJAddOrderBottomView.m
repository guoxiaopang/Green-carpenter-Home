//
//  QJAddOrderBottomView.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/16.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddOrderBottomView.h"
#import "Masonry.h"
#import "UIColor+QJColorHEX.h"

@interface QJAddOrderBottomView()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation QJAddOrderBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.button];
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
        _lineView.backgroundColor = [UIColor colorWithHex:0XEEEEEE];
    }
    return _lineView;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"提交订单" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark - Void
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

- (void)addLayout
{
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@100);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.top.equalTo(self);
    }];
}

- (void)click
{
    //提交订单
    if ([self.delegate respondsToSelector:@selector(determineCommit)])
    {
        [self.delegate determineCommit];
    }
}

@end
