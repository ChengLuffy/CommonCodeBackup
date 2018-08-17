//
//  MarqueeLabelViewController.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/13.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "MarqueeLabelViewController.h"
#import "QMUIMarqueeLabel.h"

@interface MarqueeLabelViewController ()

@property (nonatomic, strong) QMUIMarqueeLabel *label;

@end

@implementation MarqueeLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@40);
        make.width.equalTo(@(ScreenBoundsSize.width - 40));
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.label requestToStartAnimation];
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
- (QMUIMarqueeLabel *)label {
    if (_label == nil) {
        _label = [[QMUIMarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = [UIColor blackColor];
        _label.text = @"// In a storyboard-based application, you will often want to do a little preparation before navigation";
    }
    return _label;
}

@end
