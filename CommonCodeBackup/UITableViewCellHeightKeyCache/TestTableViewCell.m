//
//  TestTableViewCell.m
//  CommonCodeBackup
//
//  Created by 成殿 on 2018/8/13.
//  Copyright © 2018年 chengluffy. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    [self.contentView addSubview:self.contentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
//        make.left.mas_equalTo(self.contentView.mas_left).with.offset(5);
//        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-5);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-5);
        make.edges.equalTo(self.contentView);
    }];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize resultSize = CGSizeMake(size.width, 0);
    
    CGFloat height = 10;
    if (self.contentLabel.text.length > 0) {
        CGSize labelSize = [self.contentLabel sizeThatFits:CGSizeMake(UIScreen.mainScreen.bounds.size.width, CGFLOAT_MAX)];
        height += labelSize.height;
    }
    
    return CGSizeMake(resultSize.width, height);
}

#pragma mark - Lazy Load
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textColor = UIColor.blackColor;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"1;";
    }
    return _contentLabel;
}

@end
