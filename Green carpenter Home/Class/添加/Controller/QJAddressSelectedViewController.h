//
//  QJAddressSelectedViewController.h
//  Green carpenter Home
//
//  Created by duoyi on 16/11/15.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^address)(NSString *str);
@interface QJAddressSelectedViewController : UIViewController

@property (nonatomic, strong) address str;

@end
