//
//  QJADDOrderContentCollectionViewCell.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/17.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJADDOrderContentCollectionViewCell.h"
#import "QJMenuModel.h"
#import "Masonry.h"

@interface QJADDOrderContentCollectionViewCell()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QJADDOrderContentCollectionViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.contentLabel];
        [self addLayout];
    }
    return self;
}

- (void)setFoodArray:(NSArray *)foodArray
{
    _foodArray = foodArray;
    
    if (foodArray.count)
    {
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < foodArray.count; i++)
        {
            QJMenuModel *model = foodArray[i];
            [str appendString:model.name];
            [str appendString:@"  "];
            [str appendString:[NSString stringWithFormat:@"%@份", model.num]];
            if (i != foodArray.count - 1)
            {
                [str appendString:@"\n"];
            }
        }
        _contentLabel.text = str;
    }
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (void)addLayout
{
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(14);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.right.equalTo(self.contentView).offset(-14);
    }];
}

@end
