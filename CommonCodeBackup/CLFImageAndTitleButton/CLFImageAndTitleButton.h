//
//  CLFImageAndTitleButton.h
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/11.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImagePosition) {
   ImagePositionTop,
   ImagePositionLeft,
   ImagePositionBottom,
   ImagePositionRight
};

/**
 copy from QMUI_iOS QMUIButton
 https://github.com/QMUI/QMUI_iOS
 */
@interface CLFImageAndTitleButton : UIButton

@property (nonatomic, assign) ImagePosition imagePosition;
@property (nonatomic, assign) CGFloat spacingBetweenImageAndTitle;

@end
