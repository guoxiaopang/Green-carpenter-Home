//
//  QJInfoTableViewCell.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJInfoTableViewCell.h"

@implementation QJInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.infoLabel];
        [self addLayout];
    }
    return self;
}

- (void)addLayout
{
    
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

- (UILabel *)infoLabel
{
    if (!_infoLabel)
    {
        _infoLabel = [[UILabel alloc] init];
    }
    return _infoLabel;
}

@end
