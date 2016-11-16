//
//  QJAddressTableViewCell.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddressTableViewCell.h"
#import "Masonry.h"

@interface QJAddressTableViewCell()

@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QJAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.contentLabel];
        [self addLayout];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addLayout
{
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(14);
        make.width.equalTo(@50);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressLabel.mas_right).offset(5);
        make.right.equalTo(self.contentView).offset(-14);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
}

- (UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.text = @"地址 : ";
    }
    return _addressLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:13];
    }
    return _contentLabel;
}


- (void)changeLabelValue:(NSString *)name withNumber:(NSString *)str address:(NSString *)add
{
    NSMutableString *content = [NSMutableString string];
    if (name.length)
    {
        [content appendString:name];
        [content appendString:@"\n"];
    }
    
    if (str.length)
    {
        [content appendString:str];
        [content appendString:@"\n"];
    }
    
    [content appendString:add];
    _contentLabel.text = content;
}
@end
