//
//  CLFCellHeightKeyCachedTestViewController.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/13.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "CLFCellHeightKeyCachedTestViewController.h"
#import "TestTableViewCell.h"
#import "UITableView+QMUICellHeightKeyCache.h"

@interface CLFCellHeightKeyCachedTestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CLFCellHeightKeyCachedTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *contents = @[@"只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\n只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\n只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。\n只需要修改一份配置表就可以调整 App 的全局样式，包括颜色、导航栏、输入框、列表等。一处修改，全局生效。", @"拓展多个 UIKit 的组件，提供更加丰富的特性和功能，提高开发效率；解决不同 iOS 版本常见的兼容性问题", @"提供丰富且常用的 UI 控件，使用方便灵活，并且支持自定义控件的样式。", @"提供高效的工具方法，包括设备信息、动态字体、键盘管理、状态栏管理等，可以解决各种常见场景并大幅度提升开发效率", @"QMUI iOS 的设计目的是用于辅助快速搭建一个具备基本设计还原效果的 iOS 项目，", @"同时利用自身提供的丰富控件及兼容处理，", @"让开发者能专注于业务需求而无需耗费精力在基础代码的设计上。", @"不管是新项目的创建，或是已有项目的维护，", @"均可使开发效率和项目质量得到大幅度提升。", @"iOS UI 解决方案"];
    cell.contentLabel.text = contents[indexPath.row];
    return cell;
}

- (id<NSCopying>)qmui_tableView:(UITableView *)tableView cacheKeyForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 返回一个用于标记当前 cell 高度的 key，只要 key 不变，高度就不会重新计算，所以建议将有可能影响 cell 高度的数据字段作为 key 的一部分（例如 username、content.md5 等），这样当数据发生变化时，只要触发 cell 的渲染，高度就会自动更新
    return @(indexPath.row);// 这里简单处理，认为只要长度不同，高度就不同（但实际情况下长度就算相同，高度也有可能不同，要注意）
}

#pragma mark - Lazy Load
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.qmui_cacheCellHeightByKeyAutomatically = true;
        [_tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
