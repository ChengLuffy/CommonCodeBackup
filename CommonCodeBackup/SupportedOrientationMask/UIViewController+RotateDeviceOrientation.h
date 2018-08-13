//
//  UIViewController+RotateDeviceOrientation.h
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/13.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Runtime)

/**
 *  判断当前类是否有重写某个指定的 UIViewController 的方法
 *  @param selector 要判断的方法
 *  @return YES 表示当前类重写了指定的方法，NO 表示没有重写，使用的是 UIViewController 默认的实现
 */
- (BOOL)qmui_hasOverrideUIKitMethod:(_Nonnull SEL)selector;
@end

@interface UIViewController (RotateDeviceOrientation)

/// 在配置表 AutomaticallyRotateDeviceOrientation 功能开启的情况下，QMUI 会自动判断当前的 UIViewController 是否具备强制旋转设备方向的权利，而如果 QMUI 判断结果为没权利但你又希望当前的 UIViewController 具备这个权利，则可以重写该方法并返回 YES。
/// 默认返回 NO，也即交给 QMUI 自动判断。
- (BOOL)qmui_shouldForceRotateDeviceOrientation;
@end
