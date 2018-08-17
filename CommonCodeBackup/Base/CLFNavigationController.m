//
//  CLFNavigationController.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/13.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "CLFNavigationController.h"
#import "UIViewController+RotateDeviceOrientation.h"

@interface CLFNavigationController ()

@end

@implementation CLFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 防止弹出层脱离屏幕方向控制
- (BOOL)shouldAutorotate {
    return [self.topViewController qmui_hasOverrideUIKitMethod:_cmd] ? [self.topViewController shouldAutorotate] : YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController qmui_hasOverrideUIKitMethod:_cmd] ? [self.topViewController supportedInterfaceOrientations] : UIInterfaceOrientationMaskPortrait;
}

@end
