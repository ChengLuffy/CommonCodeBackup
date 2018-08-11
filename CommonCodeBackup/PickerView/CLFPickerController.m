//
//  CLFPickerController.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/7.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "CLFPickerController.h"

@interface CLFPickerController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableArray *pickerViewSelectedRows;
@property (nonatomic, copy) void (^selectedBlock)(NSArray *results);

@end

@implementation CLFPickerController

- (instancetype)initWithDataSource:(NSArray *)dataSource SelectedBlock:(void (^)(NSArray *))selectedBlock {
    self = [CLFPickerController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (self) {
        [self configUI];
        self.selectedBlock = selectedBlock;
        self.dataSource = dataSource;
        self.pickerViewSelectedRows = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            [self.pickerViewSelectedRows addObject:@0];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = false;
    UIView *view = self.pickerView;
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
    
    [self resizeSeparatorWithView:self.pickerView];
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
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.sureBtn];
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
    
    if (self.selectedBlock) {
        self.selectedBlock(self.pickerViewSelectedRows);
    }
    
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

- (void)yearPickerViewCancelAction {
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataSource.count;
    } else if (component == 1) {
        return [self.dataSource[[self.pickerViewSelectedRows[0] integerValue]][@"downArea"] count];
    } else if (component == 2) {
        return [self.dataSource[[self.pickerViewSelectedRows[0] integerValue]][@"downArea"][[self.pickerViewSelectedRows[1] integerValue]] count];
    } else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.dataSource[row][@"areaName"];
    } else if (component == 1) {
        return self.dataSource[[self.pickerViewSelectedRows[0] integerValue]][@"downArea"][row][@"areaName"];
    } else if (component == 2) {
        return self.dataSource[[self.pickerViewSelectedRows[0] integerValue]][@"downArea"][[self.pickerViewSelectedRows[1] integerValue]][@"downArea"][row][@"areaName"];
    } else {
        return @"";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        [self.pickerViewSelectedRows replaceObjectAtIndex:component withObject:@(row)];
        [self.pickerViewSelectedRows replaceObjectAtIndex:1 withObject:@0];
        [self.pickerViewSelectedRows replaceObjectAtIndex:2 withObject:@0];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    } else if (component == 1) {
        [self.pickerViewSelectedRows replaceObjectAtIndex:component withObject:@(row)];
        [self.pickerViewSelectedRows replaceObjectAtIndex:2 withObject:@0];
        [pickerView reloadComponent:2];
    } else if (component == 2) {
        [self.pickerViewSelectedRows replaceObjectAtIndex:component withObject:@(row)];
    }
    
    [pickerView reloadComponent:component];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 2)
        {
            singleLine.backgroundColor = [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.00f];
        }
    }
    UILabel *rowLabel = [UILabel new];
    rowLabel.textAlignment = NSTextAlignmentCenter;
    rowLabel.adjustsFontSizeToFitWidth = true;
    NSString *str = @"";
    if (component == 0) {
        str = self.dataSource[row][@"areaName"];
    } else if (component == 1) {
        str = self.dataSource[[self.pickerViewSelectedRows[0] integerValue]][@"downArea"][row][@"areaName"];
    } else if (component == 2) {
        str = self.dataSource[[self.pickerViewSelectedRows[0] integerValue]][@"downArea"][[self.pickerViewSelectedRows[1] integerValue]][@"downArea"][row][@"areaName"];
    } else {
        str = @"";
    }
    
    rowLabel.text = str;
    rowLabel.font = [UIFont systemFontOfSize:14];
    rowLabel.textColor = [UIColor blackColor];
    
    if ((component == 0 && row == [self.pickerViewSelectedRows[0] integerValue]) || (component == 1 && row == [self.pickerViewSelectedRows[1] integerValue]) || (component == 2 && row == [self.pickerViewSelectedRows[2] integerValue])) {
        rowLabel.textColor = UIColor.cyanColor;
    }
    
    return rowLabel;
}

#pragma mark - Lazy Load
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
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
