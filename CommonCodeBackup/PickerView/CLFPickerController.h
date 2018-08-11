//
//  CLFPickerController.h
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/7.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 demo 不能直接用
 即使是地址选择，遇到 新疆 某些地区也会导致字符过长没有很好的处理方式
 选择器 继承自 UIAlertController 使用 UIAlertController 生成方法 title 传 @"", message 传 nil
 */
@interface CLFPickerController : UIAlertController

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) BOOL tapBackgroundViewToDismiss;

- (instancetype)initWithDataSource:(NSArray *)dataSource SelectedBlock:(void (^)(NSArray *results))selectedBlock;

@end
