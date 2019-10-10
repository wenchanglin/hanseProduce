//
//  WCLHomeClassifyTwoCell.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/23.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeClassifyTwoCell.h"

@implementation WCLHomeClassifyTwoCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.centerX.equalTo(self.mas_centerX);
            make.width.height.mas_equalTo(43);
        }];
        [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImageView.mas_bottom).offset(4);
            make.centerX.equalTo(self.headImageView.mas_centerX);
        }];
    }
    return self;
}
-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView=[UIImageView new];
        _headImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_headImageView];
    }
    return _headImageView;
}
-(UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel=[UILabel new];
        _headLabel.textColor=[UIColor colorWithHexString:@"#666666"];
        _headLabel.font=[UIFont fontWithName:@"PingFang SC" size:13];
        [self addSubview:_headLabel];
    }
    return _headLabel;
}

-(void)setModels:(WCLHomeClassifyModel *)models{
    _models=models;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:models.img] placeholderImage:[UIImage imageNamed:@""]];
    _headLabel.text = models.cate_title;
}
@end
