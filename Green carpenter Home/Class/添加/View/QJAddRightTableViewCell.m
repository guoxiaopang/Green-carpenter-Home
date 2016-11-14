//
//  QJAddRightTableViewCell.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddRightTableViewCell.h"
#import "UIColor+QJColorHEX.h"
#import "Masonry.h"
#import "PPNumberButton.h"

@interface QJAddRightTableViewCell()<PPNumberButtonDelegate>

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) PPNumberButton *ppButton;

@end

@implementation QJAddRightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.ppButton];
        [self addLayout];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 懒加载
- (PPNumberButton *)ppButton
{
    if (!_ppButton)
    {
        CGRect rect = CGRectMake(CGRectGetWidth(self.frame) - 140, 30, 80, 20);
        _ppButton = [[PPNumberButton alloc] initWithFrame:rect];
        _ppButton.shakeAnimation = YES;
        _ppButton.minValue = 0;
        _ppButton.maxValue = 99;
        _ppButton.delegate = self;
        _ppButton.numberBlock = ^(NSString *num){
            NSLog(@"%@",num);
        };
    }
    return _ppButton;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (void)addLayout
{
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(10);
        make.top.equalTo(_iconView);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.bottom.equalTo(_iconView);
    }];
}

- (void)reloadWithModel:(QJMenuModel *)model
{
    _iconView.image = [UIImage imageNamed:model.icon];
    _nameLabel.text = model.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", model.price];
    [_ppButton setCurrNumber:model.num];
    self.model = model;
}

- (void)PPNumberButton:(UIView *)numberButton number:(NSString *)number
{
    if ([self.delegate respondsToSelector:@selector(saveDate:number:)])
    {
        [self.delegate saveDate:self number:number];
    }
}
@end
