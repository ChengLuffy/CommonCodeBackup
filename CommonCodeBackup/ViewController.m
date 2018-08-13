//
//  ViewController.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/7.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "ViewController.h"
#import "CLFDatePickerController.h"
#import "CLFPickerController.h"
#import "CLFCommonDatePickerViewController.h"
#import "ButtonViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cellTitles;
@property (nonatomic, strong) NSArray *addrArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.cellTitles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if ([self.cellTitles[indexPath.row] isEqualToString:@"Date Picker"]) {
        CLFDatePickerController *datePicker = [[CLFDatePickerController alloc] initWithSelectedBlock:^(NSDate *date) {
            NSLog(@"%@", date);
        }];
        [self presentViewController:datePicker animated:true completion:^{
        }];
    } else if ([self.cellTitles[indexPath.row] isEqualToString:@"Picker"]) {
        CLFPickerController *picker = [[CLFPickerController alloc] initWithDataSource:self.addrArray SelectedBlock:^(NSArray *results) {
            NSLog(@"%@", results);
        }];
        [self presentViewController:picker animated:true completion:^{
        }];
    } else if ([self.cellTitles[indexPath.row] isEqualToString:@"Date Picker 1"]) {
        CLFCommonDatePickerViewController *picker = [[CLFCommonDatePickerViewController alloc] init];
        self.navigationController.definesPresentationContext = YES;
        picker.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        picker.pickedDateBlock = ^(NSDate *date) {
            NSLog(@"%@", date);
        };
        picker.tapBackgroundViewToDismiss = true;
        [self.navigationController presentViewController:picker animated:true completion:^{
            
        }];
    } else if ([self.cellTitles[indexPath.row] isEqualToString:@"image title button"]) {
        ButtonViewController *vc = [[ButtonViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
    }
}

#pragma mark - Lazy Load
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)cellTitles {
    if (_cellTitles == nil) {
        _cellTitles = @[@"Date Picker", @"Date Picker 1", @"Picker", @"image title button"];
    }
    return _cellTitles;
}

- (NSArray *)addrArray {
    if (_addrArray == nil) {
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"AdressArea" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:jsonPath];
        _addrArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];;
    }
    return _addrArray;
}

@end
