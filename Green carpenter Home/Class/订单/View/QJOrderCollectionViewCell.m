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

@interface QJOrderCollectionViewCell()

@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *qianyueLabel;

@end

@implementation QJOrderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
        
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.qianyueLabel];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载

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
        make.left.equalTo(self).offset(14);
        make.top.equalTo(self).offset(15);
        make.height.width.equalTo(@(40));
        make.bottom.equalTo(self).offset(-40);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(14);
        make.top.equalTo(_iconView);
    }];
    
    [_qianyueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(10);
        make.top.equalTo(_iconView);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"%@",_iconView);
}

@end
