//
//  QJAddressTableViewCell.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJAddressTableViewCell : UITableViewCell

@property(nonatomic, strong) NSString *address;

- (void)changeLabelValue:(NSString *)name withNumber:(NSString *)str address:(NSString *)add;

@end
