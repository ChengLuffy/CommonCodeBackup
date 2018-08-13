//
//  UIViewController+RotateDeviceOrientation.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/13.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "UIViewController+RotateDeviceOrientation.h"
#import "NSObject+QMUI.h"
#import "CLFHeader.h"

@implementation UIViewController (Runtime)

- (BOOL)qmui_hasOverrideUIKitMethod:(SEL)selector {
    // 排序依照 Xcode Interface Builder 里的控件排序，但保证子类在父类前面
    NSMutableArray<Class> *viewControllerSuperclasses = [[NSMutableArray alloc] initWithObjects:
                                                         [UIImagePickerController class],
                                                         [UINavigationController class],
                                                         [UITableViewController class],
                                                         [UICollectionViewController class],
                                                         [UITabBarController class],
                                                         [UISplitViewController class],
                                                         [UIPageViewController class],
                                                         [UIViewController class],
                                                         nil];
    
    if (NSClassFromString(@"UIAlertController")) {
        [viewControllerSuperclasses addObject:[UIAlertController class]];
    }
    if (NSClassFromString(@"UISearchController")) {
        [viewControllerSuperclasses addObject:[UISearchController class]];
    }
    for (NSInteger i = 0, l = viewControllerSuperclasses.count; i < l; i++) {
        Class superclass = viewControllerSuperclasses[i];
        if ([self qmui_hasOverrideMethod:selector ofSuperclass:superclass]) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation UIViewController (RotateDeviceOrientation)

void qmui_loadViewIfNeeded (id current_self, SEL current_cmd) {
    // 主动调用 self.view，从而触发 loadView，以模拟 iOS 9.0 以下的系统 loadViewIfNeeded 行为
    [((UIViewController *)current_self) view];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 实现 AutomaticallyRotateDeviceOrientation 开关的功能
        ExchangeImplementations([UIViewController class], @selector(viewWillAppear:), @selector(rotate_viewWillAppear:));
    });
}

- (void)rotate_viewWillAppear:(BOOL)animated {
    [self rotate_viewWillAppear:animated];
//    if (!AutomaticallyRotateDeviceOrientation) {
//        return;
//    }
    
    // 某些情况下的 UIViewController 不具备决定设备方向的权利，具体请看 https://github.com/QMUI/QMUI_iOS/issues/291
    if (![self qmui_shouldForceRotateDeviceOrientation]) {
        BOOL isRootViewController = [self isViewLoaded] && self.view.window.rootViewController == self;
        BOOL isChildViewController = [self.tabBarController.viewControllers containsObject:self] || [self.navigationController.viewControllers containsObject:self] || [self.splitViewController.viewControllers containsObject:self];
        BOOL hasRightsOfRotateDeviceOrientaion = isRootViewController || isChildViewController;
        if (!hasRightsOfRotateDeviceOrientaion) {
            return;
        }
    }
    
    
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIDeviceOrientation deviceOrientationBeforeChangingByHelper = self.orientationBeforeChangingByHelper;
    BOOL shouldConsiderBeforeChanging = deviceOrientationBeforeChangingByHelper != UIDeviceOrientationUnknown;
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    // 虽然这两者的 unknow 值是相同的，但在启动 App 时可能只有其中一个是 unknown
    if (statusBarOrientation == UIInterfaceOrientationUnknown || deviceOrientation == UIDeviceOrientationUnknown) return;
    
    // 如果当前设备方向和界面支持的方向不一致，则主动进行旋转
    UIDeviceOrientation deviceOrientationToRotate = [self interfaceOrientationMask:self.supportedInterfaceOrientations containsDeviceOrientation:deviceOrientation] ? deviceOrientation : [self deviceOrientationWithInterfaceOrientationMask:self.supportedInterfaceOrientations];
    
    // 之前没用私有接口修改过，那就按最标准的方式去旋转
    if (!shouldConsiderBeforeChanging) {
        if ([self rotateToDeviceOrientation:deviceOrientationToRotate]) {
            self.orientationBeforeChangingByHelper = deviceOrientation;
        } else {
            self.orientationBeforeChangingByHelper = UIDeviceOrientationUnknown;
        }
        return;
    }
    
    // 用私有接口修改过方向，但下一个界面和当前界面方向不相同，则要把修改前记录下来的那个设备方向考虑进来
    deviceOrientationToRotate = [self interfaceOrientationMask:self.supportedInterfaceOrientations containsDeviceOrientation:deviceOrientationBeforeChangingByHelper] ? deviceOrientationBeforeChangingByHelper : [self deviceOrientationWithInterfaceOrientationMask:self.supportedInterfaceOrientations];
    [self rotateToDeviceOrientation:deviceOrientationToRotate];
}

- (BOOL)qmui_shouldForceRotateDeviceOrientation {
    return NO;
}

- (void)handleDeviceOrientationNotification:(NSNotification *)notification {
    // 如果是由 setValue:forKey: 方式修改方向而走到这个 notification 的话，理论上是不需要重置为 Unknown 的，但因为在 UIViewController (QMUI) 那边会再次记录旋转前的值，所以这里就算重置也无所谓
    self.orientationBeforeChangingByHelper = UIDeviceOrientationUnknown;
}

- (BOOL)interfaceOrientationMask:(UIInterfaceOrientationMask)mask containsDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    if (deviceOrientation == UIDeviceOrientationUnknown) {
        return YES;// YES 表示不用额外处理
    }
    
    if ((mask & UIInterfaceOrientationMaskAll) == UIInterfaceOrientationMaskAll) {
        return YES;
    }
    if ((mask & UIInterfaceOrientationMaskAllButUpsideDown) == UIInterfaceOrientationMaskAllButUpsideDown) {
        return UIInterfaceOrientationPortraitUpsideDown != deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskPortrait) == UIInterfaceOrientationMaskPortrait) {
        return UIInterfaceOrientationPortrait == deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskLandscape) == UIInterfaceOrientationMaskLandscape) {
        return UIInterfaceOrientationLandscapeLeft == deviceOrientation || UIInterfaceOrientationLandscapeRight == deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskLandscapeLeft) == UIInterfaceOrientationMaskLandscapeLeft) {
        return UIInterfaceOrientationLandscapeLeft == deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskLandscapeRight) == UIInterfaceOrientationMaskLandscapeRight) {
        return UIInterfaceOrientationLandscapeRight == deviceOrientation;
    }
    if ((mask & UIInterfaceOrientationMaskPortraitUpsideDown) == UIInterfaceOrientationMaskPortraitUpsideDown) {
        return UIInterfaceOrientationPortraitUpsideDown == deviceOrientation;
    }
    
    return YES;
}

- (UIDeviceOrientation)deviceOrientationWithInterfaceOrientationMask:(UIInterfaceOrientationMask)mask {
    if ((mask & UIInterfaceOrientationMaskAll) == UIInterfaceOrientationMaskAll) {
        return [UIDevice currentDevice].orientation;
    }
    if ((mask & UIInterfaceOrientationMaskAllButUpsideDown) == UIInterfaceOrientationMaskAllButUpsideDown) {
        return [UIDevice currentDevice].orientation;
    }
    if ((mask & UIInterfaceOrientationMaskPortrait) == UIInterfaceOrientationMaskPortrait) {
        return UIDeviceOrientationPortrait;
    }
    if ((mask & UIInterfaceOrientationMaskLandscape) == UIInterfaceOrientationMaskLandscape) {
        return [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ? UIDeviceOrientationLandscapeLeft : UIDeviceOrientationLandscapeRight;
    }
    if ((mask & UIInterfaceOrientationMaskLandscapeLeft) == UIInterfaceOrientationMaskLandscapeLeft) {
        return UIDeviceOrientationLandscapeRight;
    }
    if ((mask & UIInterfaceOrientationMaskLandscapeRight) == UIInterfaceOrientationMaskLandscapeRight) {
        return UIDeviceOrientationLandscapeLeft;
    }
    if ((mask & UIInterfaceOrientationMaskPortraitUpsideDown) == UIInterfaceOrientationMaskPortraitUpsideDown) {
        return UIDeviceOrientationPortraitUpsideDown;
    }
    return [UIDevice currentDevice].orientation;
}


- (BOOL)rotateToDeviceOrientation:(UIDeviceOrientation)orientation {
    if ([UIDevice currentDevice].orientation == orientation) {
        [UIViewController attemptRotationToDeviceOrientation];
        return NO;
    }
    
    [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
    return YES;
}

static char kAssociatedObjectKey_orientationBeforeChangedByHelper;
- (void)setOrientationBeforeChangingByHelper:(UIDeviceOrientation)orientationBeforeChangedByHelper {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_orientationBeforeChangedByHelper, @(orientationBeforeChangedByHelper), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIDeviceOrientation)orientationBeforeChangingByHelper {
    return [((NSNumber *)objc_getAssociatedObject(self, &kAssociatedObjectKey_orientationBeforeChangedByHelper)) integerValue];
}

+ (CGFloat)angleForTransformWithInterfaceOrientation:(UIInterfaceOrientation)orientation {
    CGFloat angle;
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }
    return angle;
}

+ (CGAffineTransform)transformForCurrentInterfaceOrientation {
    return [self transformWithInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

+ (CGAffineTransform)transformWithInterfaceOrientation:(UIInterfaceOrientation)orientation {
    CGFloat angle = [self angleForTransformWithInterfaceOrientation:orientation];
    return CGAffineTransformMakeRotation(angle);
}

@end
