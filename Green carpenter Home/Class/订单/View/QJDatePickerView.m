//
//  QJDatePickerView.m
//  Green carpenter Home
//
//  Created by duoyi on 16/11/10.
//  Copyright © 2016年 Green carpenter Home. All rights reserved.
//

#import "QJDatePickerView.h"
#import "Masonry.h"

@interface QJDatePickerView()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *finishButton;

@end

@implementation QJDatePickerView
{
    NSString *_dateString;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.cancelButton];
        [self.bottomView addSubview:self.finishButton];
        [self.bottomView addSubview:self.datePicker];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:self.tintColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)finishButton
{
    if (!_finishButton)
    {
        _finishButton = [[UIButton alloc] init];
        [_finishButton setTitle:@"Done" forState:UIControlStateNormal];
        [_finishButton setTitleColor:self.tintColor forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishButton;
}

- (UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = 5.0f;
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

#pragma mark - Void

- (void)show
{
    _dateString = nil;
    _datePicker.date = [NSDate date];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)closeView
{
    [self removeFromSuperview];
}

- (void)addLayout
{
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@(240));
        make.center.equalTo(self);
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView).offset(10);
        make.top.equalTo(_bottomView).offset(10);
    }];
    
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView).offset(-10);
        make.centerY.equalTo(_cancelButton);
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cancelButton.mas_bottom);
        make.left.right.bottom.equalTo(_bottomView);
    }];
}

- (void)dateChange:(UIDatePicker *)picker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:picker.date];
    _dateString = date;
}

- (void)done
{
    if (_dateString)
    {
        self.str(_dateString);
    }
    else
    {
        self.str([self currDate]);
    }
    [self closeView];
}

- (NSString *)currDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    return  [fmt stringFromDate:date];
}

@end
