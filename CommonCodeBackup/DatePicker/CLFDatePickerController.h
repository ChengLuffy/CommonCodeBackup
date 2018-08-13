//
//  CLFDatePickerController.h
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/7.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "UIViewController+RotateDeviceOrientation.h"

/**
 日期选择器 继承自 UIAlertController 使用 UIAlertController 生成方法 title 传 @"", message 传 nil
 */
@interface CLFDatePickerController : UIAlertController

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, assign) BOOL tapBackgroundViewToDismiss;

- (instancetype)initWithSelectedBlock:(void (^)(NSDate *date))selectedDate;

@end
