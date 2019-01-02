//
//  CLFZoomImageViewCell.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/17.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "CLFZoomImageViewCell.h"
#import "UIImageView+WebCache.h"

@interface CLFZoomImageViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CLFZoomImageViewCell

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (self.imageView == nil) {
        return;
    }
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.scrollView);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width/3*2)];
    self.imageView.center = self.contentView.center;
    self.scrollView.contentSize = self.imageView.frame.size;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.imageView.center = self.contentView.center;
    self.scrollView.contentSize = self.imageView.frame.size;
    if (self.imageView.frame.size.height > UIScreen.mainScreen.bounds.size.height) {
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
    if (self.imageView.frame.size.width > UIScreen.mainScreen.bounds.size.width) {
        self.imageView.frame = CGRectMake(0, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    if (image == nil) {
        return;
    }
    
    self.imageView.image = image;
    self.imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, self.image.size.height*(UIScreen.mainScreen.bounds.size.width/self.image.size.width));
    self.imageView.center = self.contentView.center;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    __weak __typeof(self)weakSelf = self;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", imageUrl]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, image.size.height*(UIScreen.mainScreen.bounds.size.width/image.size.width));
        weakSelf.imageView.center = weakSelf.contentView.center;
    }];
}

#pragma mark - Lazy Load
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale=3.0;
        _scrollView.minimumZoomScale=1;
    }
    return _scrollView;
}

@end
