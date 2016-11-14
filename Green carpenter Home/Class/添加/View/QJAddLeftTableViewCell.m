//
//  QJAddLeftTableViewCell.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/14.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJAddLeftTableViewCell.h"
#import "Masonry.h"
#import "UIColor+QJColorHEX.h"

@interface QJAddLeftTableViewCell()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation QJAddLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.nameLabel];
        [self addLayout];
        self.contentView.backgroundColor = [UIColor colorWithHex:0XEEEEEE];
    }
    return self;
}

#pragma mark - Void
- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (void)reloadData:(NSString *)str
{
    _nameLabel.text = str;
}

- (void)addLayout
{
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
}

- (void)seleted:(BOOL)statu
{
    if (statu)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor colorWithHex:0XEEEEEE];
    }
}

@end
