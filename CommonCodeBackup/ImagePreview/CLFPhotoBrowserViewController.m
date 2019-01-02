//
//  CLFPhotoBrowserViewController.m
//  GangubangStoreSide
//
//  Created by 成殿 on 2018/6/27.
//  Copyright © 2018年 干股商城. All rights reserved.
//

#import "CLFPhotoBrowserViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CLFPhotoBrowserViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation CLFPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    __weak __typeof(self)weakSelf = self;
    self.scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width/3*2)];
//    if (self.image != nil) {
//        self.imageView.image=self.image;
//        self.imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, self.image.size.height*(UIScreen.mainScreen.bounds.size.width/self.image.size.width));
//    } else if (self.imageUrl != nil && ![self.imageUrl isEqualToString:@""]) {
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.imageUrl]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            weakSelf.imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, image.size.height*(UIScreen.mainScreen.bounds.size.width/image.size.width));
//        }];
//    }
    
    self.imageView.center = self.view.center;
    [self.scrollView addSubview:self.imageView];
    
    self.scrollView.contentSize = self.imageView.frame.size;
    
    self.scrollView.delegate=self;
    self.scrollView.maximumZoomScale=3.0;
    self.scrollView.minimumZoomScale=1;
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    self.closeBtn.layer.cornerRadius = 5;
    [self.closeBtn setImage:[UIImage imageNamed:@"close" inBundle:nil compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.closeBtn];
    
    self.view.backgroundColor = [UIColor blackColor];
    if (self.imageView.frame.size.height > UIScreen.mainScreen.bounds.size.height) {
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
    if (self.imageView.frame.size.width > UIScreen.mainScreen.bounds.size.width) {
        self.imageView.frame = CGRectMake(0, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(20);
        } else {
            // Fallback on earlier versions
            make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        }
        make.left.mas_equalTo(self.view.mas_left).with.offset(30);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
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

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    __weak __typeof(self)weakSelf = self;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", imageUrl]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, image.size.height*(UIScreen.mainScreen.bounds.size.width/image.size.width));
        weakSelf.imageView.center = weakSelf.view.center;
    }];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
    self.imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, self.image.size.height*(UIScreen.mainScreen.bounds.size.width/self.image.size.width));
    self.imageView.center = self.view.center;
}

#pragma mark - Actions
- (void)closeBtnAction {
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.imageView.center = self.view.center;
    self.scrollView.contentSize = self.imageView.frame.size;
    if (self.imageView.frame.size.height > UIScreen.mainScreen.bounds.size.height) {
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
    if (self.imageView.frame.size.width > UIScreen.mainScreen.bounds.size.width) {
        self.imageView.frame = CGRectMake(0, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
}

@end
