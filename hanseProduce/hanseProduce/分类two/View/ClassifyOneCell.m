//
//  ClassifyOneCell.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ClassifyOneCell.h"

@implementation ClassifyOneCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.line];
    }
    return self;
}
-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self.line setHidden:!selected];
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.line.width = 2;
    self.line.height = YBLWidth_Scale*(27);
    self.line.centerY = self.contentView.height * 0.5;
    self.line.left = 1;
    self.titleLabel.height = YBLWidth_Scale*(18);
    self.titleLabel.width = self.contentView.width - self.line.right;
    self.titleLabel.right = self.contentView.width;
    self.titleLabel.centerY = self.contentView.height * 0.5;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:YBLWidth_Scale*(14)];
        _titleLabel.textColor = [UIColor f6];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)line {
    if (!_line) {
        _line = [UIView new];
        [_line setHidden:YES];
        _line.backgroundColor = [UIColor py_colorWithHexString:@"D05142"];
    }
    return _line;
}
@end
