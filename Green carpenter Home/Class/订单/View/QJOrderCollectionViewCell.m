//
//  QJOrderCollectionViewCell.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJOrderCollectionViewCell.h"
#import "Masonry.h"
#import "UIImage+QJRadiuImage.h"
#import "UIColor+QJColorHEX.h"
#import "QJOrderCollectionBottomView.h"

@interface QJOrderCollectionViewCell()<UIAlertViewDelegate, QJOrderCollectionBottomViewDelegate>

@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *nameLabel;
// 订单状态
@property(nonatomic, strong) UILabel *qianyueLabel;
// 达达状态
@property(nonatomic, strong) UILabel *dadaLabel;
// 时间
@property(nonatomic, strong) UILabel *timeLabel;
// 电话
@property(nonatomic, strong) UILabel *numberLabel;
// 地址
@property(nonatomic, strong) UILabel *addressLabel;
// 点餐内容
@property(nonatomic, strong) UILabel *contentLabel;
// 总价
@property(nonatomic, strong) UILabel *totalPrice;
// 订单号
@property(nonatomic, strong) UILabel *orderNumberLabel;
// 备注
@property(nonatomic, strong) UILabel *infoLabel;
// 按钮栏
@property(nonatomic, strong) QJOrderCollectionBottomView *buttomView;

@end

@implementation QJOrderCollectionViewCell
{
    NSString *_phoneNumber;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.qianyueLabel];
        [self.contentView addSubview:self.dadaLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.totalPrice];
        [self.contentView addSubview:self.orderNumberLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.infoLabel];
        [self.contentView addSubview:self.buttomView];
        [self addLayout];
    }
    return self;
}

- (void)reloadModel:(QJOrderListModel *)model
{
    _nameLabel.text = model.receiver_name;
    _qianyueLabel.text = [self status:model.status];
    if (model.status == 0)
    {
        _qianyueLabel.textColor = self.tintColor;
        _qianyueLabel.layer.borderColor = self.tintColor.CGColor;
    }
    else if(model.status == 1)
    {
        _qianyueLabel.textColor = [UIColor greenColor];
        _qianyueLabel.layer.borderColor = [UIColor greenColor].CGColor;
    }
    else if (model.status == -1)
    {
        _qianyueLabel.textColor = [UIColor redColor];
        _qianyueLabel.layer.borderColor = [UIColor redColor].CGColor;
    }
    _timeLabel.text = [self timeFormat:model.expected_fetch_time];
    _totalPrice.text = [NSString stringWithFormat:@"合计 : %.2f元", model.cargo_price];
    if ([model.receiver_phone boolValue])
    {
        _phoneNumber = model.receiver_phone;
    }
    else
    {
        _phoneNumber = model.receiver_tel;
    }
    _numberLabel.text = [NSString stringWithFormat:@"电话 : %@", _phoneNumber];
    _addressLabel.text = [NSString stringWithFormat: @"地址 : %@", model.receiver_address];
    _orderNumberLabel.text = [NSString stringWithFormat:@"订单号 : %@", model.order_id];
    
    //设置按钮状态
    [self.buttomView setPrint:model.status];
}

/// 返回格式化后时间
- (NSString *)timeFormat:(long)time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM月dd日 HH时mm分";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [fmt stringFromDate:date];
}

- (NSString *)status:(NSInteger)index
{
    switch (index)
    {
        case 0:
            return @"待接单";
            break;
        case 1:
            return @"已接单";
            break;
        case -1:
            return @"已取消";
            break;
        case 2:
            return @"待评价";
            break;
        case 3:
            return @"已完成";
            break;
    }
    return @"未知状态";
}

#pragma mark - 懒加载
- (QJOrderCollectionBottomView *)buttomView
{
    if (!_buttomView)
    {
        _buttomView = [[QJOrderCollectionBottomView alloc] init];
        _buttomView.delegate = self;
    }
    return _buttomView;
}

- (UILabel *)infoLabel
{
    if (!_infoLabel)
    {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"备注 : 多一点辣椒";
        _infoLabel.font = [UIFont systemFontOfSize:14];
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}

- (UILabel *)orderNumberLabel
{
    if (!_orderNumberLabel)
    {
        _orderNumberLabel = [[UILabel alloc] init];
        _orderNumberLabel.text = @"订单号 : 000000";
        _orderNumberLabel.font = [UIFont systemFontOfSize:14];
        _orderNumberLabel.textColor = self.tintColor;
        _orderNumberLabel.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(orderLongPress)];
        [_orderNumberLabel addGestureRecognizer:longPress];
    }
    return _orderNumberLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"牛肉面 X2\n杂酱面 X2";
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)totalPrice
{
    if (!_totalPrice)
    {
        _totalPrice = [[UILabel alloc] init];
        _totalPrice.textColor = [UIColor redColor];
        _totalPrice.font = [UIFont systemFontOfSize:16];
        _totalPrice.text = @"0份0元";
    }
    return _totalPrice;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textColor = [UIColor colorWithHex:0X635E63];
        _addressLabel.font = [UIFont systemFontOfSize:13];
        _addressLabel.numberOfLines = 0;
        _addressLabel.text = @"地址 : ";
    }
    return _addressLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel)
    {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor colorWithHex:0X635E63];
        _numberLabel.font = [UIFont systemFontOfSize:13];
        _numberLabel.text = @"电话 : ";
        _numberLabel.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(numberLongPress:)];
        [_numberLabel addGestureRecognizer:longPress];
    }
    return _numberLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor greenColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.text = @"时间未知";
    }
    return _timeLabel;
}

- (UILabel *)dadaLabel
{
    if (!_dadaLabel)
    {
        _dadaLabel = [[UILabel alloc] init];
        _dadaLabel.font = [UIFont systemFontOfSize:12];
        _dadaLabel.text = @"达达状态";
        _dadaLabel.textColor = self.tintColor;
        _dadaLabel.layer.borderWidth = 1.0f;
        _dadaLabel.layer.borderColor = self.tintColor.CGColor;
    }
    return _dadaLabel;
}

- (UILabel *)qianyueLabel
{
    if (!_qianyueLabel)
    {
        _qianyueLabel = [[UILabel alloc] init];
        _qianyueLabel.font = [UIFont systemFontOfSize:12];
        _qianyueLabel.text = @"未知状态";
        _qianyueLabel.textColor = self.tintColor;
        _qianyueLabel.layer.borderWidth = 1.0f;
        _qianyueLabel.layer.borderColor = self.tintColor.CGColor;
    }
    return _qianyueLabel;
}

- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"icon"];
        image = [image circleImage];
        _iconView.image = image;
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"占位名字";
    }
    return _nameLabel;
}

#pragma mark - Void
- (void)addLayout
{
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(14);
        make.top.equalTo(self.contentView).offset(15);
        make.height.width.equalTo(@(40));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(14);
        make.top.equalTo(_iconView);
    }];
    
    [_qianyueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(10);
        make.centerY.equalTo(_nameLabel);
    }];
    
    [_dadaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-14);
        make.centerY.equalTo(_qianyueLabel);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
    }];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView);
        make.top.equalTo(_iconView.mas_bottom).offset(10);
    }];
    
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_dadaLabel);
        make.centerY.equalTo(_timeLabel).offset(10);
    }];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20 - 28;
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(14);
        make.width.mas_equalTo(width);
        make.top.equalTo(_numberLabel.mas_bottom).offset(5);
    }];
    
    [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numberLabel);
        make.width.equalTo(@150);
        make.top.equalTo(_addressLabel.mas_bottom).offset(5);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderNumberLabel);
        make.width.equalTo(@(width));
        make.top.equalTo(_orderNumberLabel.mas_bottom).offset(10);
    }];
    
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentLabel);
        make.top.equalTo(_contentLabel.mas_bottom).offset(10);
//        make.bottom.equalTo(self.contentView).offset(-14);
    }];
    
    [_buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_infoLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@44);
    }];
}

// 电话 长按复制
- (void)numberLongPress:(UILongPressGestureRecognizer *)longPress
{
    NSLog(@"numberLongPress");
    if (longPress.state == UIGestureRecognizerStateRecognized)
    {
        //获得菜单
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = @"确定拨打电话?";
        NSString *str = [_numberLabel.text stringByReplacingOccurrencesOfString:@"电话 : " withString:@""];
        _phoneNumber = str;
        alertView.message = str;
        alertView.delegate = self;
        [alertView addButtonWithTitle:@"确定"];
        [alertView addButtonWithTitle:@"取消"];
        [alertView show];
    }

}

// 订单号 长按复制
- (void)orderLongPress
{
    [self becomeFirstResponder];// 不是在控制器中 需要注册第一响应者
    UIMenuController *menu = [UIMenuController sharedMenuController];
    CGRect rect = _orderNumberLabel.frame;
    [menu setTargetRect:rect inView:self.contentView];
    [menu setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

// 内部显示内容
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:))
    {
        return YES;
    }
    return NO;
}

- (void)copy:(UIMenuController *)menu
{
    // 存储文字到剪切板
    NSString *str = [_orderNumberLabel.text stringByReplacingOccurrencesOfString:@"订单号 : " withString:@""];
    [UIPasteboard generalPasteboard].string = str;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if (buttonIndex == 0)
    {
        [self call];
    }
}

- (void)call
{
    NSURL *url = [NSURL URLWithString:_phoneNumber];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"设备不支持拨打电话");
    }
}

#pragma mark - QJOrderCollectionBottomViewDelegate
- (void)callPhone:(QJOrderCollectionBottomView *)view
{
    //获得菜单
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.title = @"确定拨打电话?";
    NSString *str = [_numberLabel.text stringByReplacingOccurrencesOfString:@"电话 : " withString:@""];
    _phoneNumber = str;
    alertView.message = str;
    alertView.delegate = self;
    [alertView addButtonWithTitle:@"确定"];
    [alertView addButtonWithTitle:@"取消"];
    [alertView show];
}

/// 接单操作
- (void)orders:(QJOrderCollectionBottomView *)view
{
    if ([self.delegate respondsToSelector:@selector(clickOrder:)])
    {
        [self.delegate clickOrder:self];
    }
}
/// 打印操作
- (void)printData:(QJOrderCollectionBottomView *)view
{
    NSLog(@"打印");
}

/// 取消订单
- (void)cancelOrder:(QJOrderCollectionBottomView *)view
{
    if ([self.delegate respondsToSelector:@selector(cancelOrder:)])
    {
        [self.delegate cancelOrder:self];
    }
}
@end
