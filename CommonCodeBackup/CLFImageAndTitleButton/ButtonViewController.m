//
//  ButtonViewController.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/11.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "ButtonViewController.h"
#import "CLFImageAndTitleButton.h"

@interface ButtonViewController ()

@property (nonatomic, strong) CLFImageAndTitleButton *btn1;
@property (nonatomic, strong) CLFImageAndTitleButton *btn2;
@property (nonatomic, strong) CLFImageAndTitleButton *btn3;
@property (nonatomic, strong) CLFImageAndTitleButton *btn4;

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(84);
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.btn1.mas_bottom).with.offset(20);
    }];
    
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.btn2.mas_bottom).with.offset(20);
    }];
    
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.btn3.mas_bottom).with.offset(20);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Lazy Load
- (CLFImageAndTitleButton *)btn1 {
    if (_btn1 == nil) {
        _btn1 = [CLFImageAndTitleButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [_btn1 setTitle:@"WeChat" forState:UIControlStateNormal];
        [_btn1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _btn1.imagePosition = ImagePositionTop;
        _btn1.spacingBetweenImageAndTitle = 10.f;
        _btn1.backgroundColor = UIColor.cyanColor;
    }
    return _btn1;
}

- (CLFImageAndTitleButton *)btn2 {
    if (_btn2 == nil) {
        _btn2 = [CLFImageAndTitleButton buttonWithType:UIButtonTypeCustom];
        [_btn2 setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [_btn2 setTitle:@"WeChat" forState:UIControlStateNormal];
        [_btn2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _btn2.imagePosition = ImagePositionLeft;
        _btn2.spacingBetweenImageAndTitle = 10.f;
        _btn2.backgroundColor = UIColor.cyanColor;
    }
    return _btn2;
}

- (CLFImageAndTitleButton *)btn3 {
    if (_btn3 == nil) {
        _btn3 = [CLFImageAndTitleButton buttonWithType:UIButtonTypeCustom];
        [_btn3 setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [_btn3 setTitle:@"WeChat" forState:UIControlStateNormal];
        [_btn3 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _btn3.imagePosition = ImagePositionRight;
        _btn3.spacingBetweenImageAndTitle = 10.f;
        _btn3.backgroundColor = UIColor.cyanColor;
    }
    return _btn3;
}

- (CLFImageAndTitleButton *)btn4 {
    if (_btn4 == nil) {
        _btn4 = [CLFImageAndTitleButton buttonWithType:UIButtonTypeCustom];
        [_btn4 setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [_btn4 setTitle:@"W" forState:UIControlStateNormal];
        [_btn4 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _btn4.imagePosition = ImagePositionBottom;
        _btn4.spacingBetweenImageAndTitle = 10.f;
        _btn4.backgroundColor = UIColor.cyanColor;
    }
    return _btn4;
}

@end
