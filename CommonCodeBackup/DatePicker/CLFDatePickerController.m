//
//  CLFDatePickerController.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/7.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "CLFDatePickerController.h"

@interface CLFDatePickerController ()

@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, copy) void (^selectedDateBlock)(NSDate *date);

@end

@implementation CLFDatePickerController

- (instancetype)initWithSelectedBlock:(void (^)(NSDate *date))selectedDateBlock {
    self = [CLFDatePickerController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (self) {
        [self configUI];
        self.selectedDateBlock = selectedDateBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.tapBackgroundViewToDismiss) {
        NSArray *subviews = [UIApplication sharedApplication].keyWindow.subviews;
        for (UIView *view in subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UITransitionView")]) {
                UIView *subview = [view.subviews firstObject];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yearPickerViewCancelAction)];
                subview.userInteractionEnabled = true;
                [subview addGestureRecognizer:tap];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI {
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.sureBtn];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.datePicker.translatesAutoresizingMaskIntoConstraints = false;
    UIView *view = self.datePicker;
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-30-[view]|"
                               options:0l
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(view)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-20-[view]-20-|"
                               options:0l
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(view)]];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(5);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-40);
        make.height.equalTo(@30);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(5);
        make.left.mas_equalTo(self.view.mas_left).with.offset(40);
        make.height.equalTo(@30);
    }];
    
    [self resizeSeparatorWithView:self.datePicker];
}

- (void)resizeSeparatorWithView:(UIView *)view {
    if(view.subviews != 0) {
        if(view.bounds.size.height <= 1) {
            view.frame = CGRectMake(view.frame.origin.x+10, view.frame.origin.y, view.frame.size.width-20, view.frame.size.height);
        }
        [view.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [self resizeSeparatorWithView:obj];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self yearPickerViewCancelAction];
}

#pragma mark - Actions
- (void)yearPickerViewDoneAction {
    NSDate *date = self.datePicker.date;
    
    if (self.selectedDateBlock) {
        self.selectedDateBlock(date);
    }
    
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

- (void)yearPickerViewCancelAction {
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

#pragma mark - Lazy Load
- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        [_datePicker setDatePickerMode:(UIDatePickerModeDate)];
    }
    return _datePicker;
}

- (UIButton *)sureBtn {
    if (_sureBtn == nil) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(yearPickerViewDoneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(yearPickerViewCancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
