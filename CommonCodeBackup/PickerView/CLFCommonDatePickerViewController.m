//
//  CLFCommonDatePickerViewController.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/11.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "CLFCommonDatePickerViewController.h"

@interface CLFCommonDatePickerViewController ()

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation CLFCommonDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.datePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.tapBackgroundViewToDismiss) {
        [self cancelAction];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.datePicker.mas_top);
        make.height.equalTo(@40);
    }];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.equalTo(@300);
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

- (void)cancelAction {
    self.view.backgroundColor = UIColor.clearColor;
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

- (void)sureAction {
    self.view.backgroundColor = UIColor.clearColor;
    self.pickedDateBlock(self.datePicker.date);
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolBar.backgroundColor = UIColor.whiteColor;
        UIBarButtonItem *cancelBBI = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
        UIBarButtonItem *sureBBI = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = @"请选择日期";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = UIColor.lightGrayColor;
        label.frame = CGRectMake(0, 10, UIScreen.mainScreen.bounds.size.width - 120, 30);
        label.textAlignment = NSTextAlignmentCenter;
        UIBarButtonItem *labelBBI = [[UIBarButtonItem alloc] initWithCustomView:label];
        UIBarButtonItem *btnSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        btnSpace1.width = 20;
        UIBarButtonItem *btnSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        btnSpace2.width = 20;
        
        [_toolBar setItems:@[btnSpace1, cancelBBI, labelBBI, sureBBI, btnSpace2]];
    }
    return _toolBar;
}

- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        _datePicker.backgroundColor = UIColor.whiteColor;
    }
    return _datePicker;
}

@end
