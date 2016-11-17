//
//  QJInfoTableViewCell.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJInfoTableViewCell.h"
#import "Masonry.h"

@implementation QJInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.infoLabel];
        [self.contentView addSubview:self.textField];
        [self addLayout];
    }
    return self;
}

- (void)addLayout
{
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(14);
        make.width.equalTo(@50);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_infoLabel.mas_right);
        make.centerY.equalTo(_infoLabel);
        make.right.equalTo(self.contentView).offset(-14);
    }];
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入备注";
    }
    return _textField;
}

- (UILabel *)infoLabel
{
    if (!_infoLabel)
    {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"备注 : ";
    }
    return _infoLabel;
}

@end
