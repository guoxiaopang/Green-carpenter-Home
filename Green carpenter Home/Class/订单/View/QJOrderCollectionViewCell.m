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

@interface QJOrderCollectionViewCell()

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

@end

@implementation QJOrderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.qianyueLabel];
        [self.contentView addSubview:self.dadaLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.totalPrice];
        [self.contentView addSubview:self.contentLabel];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"牛肉面 X2\n杂酱面 X2\n";
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
        _totalPrice.text = @"2份24元";
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
        _addressLabel.text = @"地址 : 广州市黄浦区伴河路90号3单元4楼5号3单元4楼5号广州市黄浦区伴河路90号3单元4楼5号3单元4楼5号";
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
        _numberLabel.text = @"电话 : 136062356010";
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
        _timeLabel.text = @"11月11号  11:20";
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
        _qianyueLabel.text = @"已接单";
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
        make.bottom.equalTo(self.contentView).offset(-200);
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
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressLabel);
        make.width.equalTo(@(width));
        make.top.equalTo(_addressLabel.mas_bottom).offset(5);
    }];
}



@end
