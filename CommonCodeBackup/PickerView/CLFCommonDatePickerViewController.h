//
//  CLFCommonDatePickerViewController.h
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/11.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLFCommonDatePickerViewController : UIViewController

@property (nonatomic, copy) void (^pickedDateBlock)(NSDate *date);

@property (nonatomic, assign) BOOL tapBackgroundViewToDismiss;

@end
