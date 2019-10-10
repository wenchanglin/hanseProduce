//
//  WCLHomeThemeCollectionCell.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeThemeCollectionCell.h"
@interface WCLHomeThemeCollectionCell()

@end
@implementation WCLHomeThemeCollectionCell
-(void)setupLayout
{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(5);
        make.bottom.right.mas_equalTo(-5);
    }];
    [self.backImageView layoutIfNeeded];
    [self.backImageView addCornerRadius:6 rectCorner:UIRectCornerAllCorners];
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(12);
        make.width.height.mas_equalTo(158);
    }];
    [self.titlelabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picImageView.mas_bottom).offset(0);
        make.left.equalTo(self.picImageView.mas_left).offset(12);
        make.right.equalTo(self.picImageView.mas_right).offset(-12);
        make.height.mas_equalTo(60);
    }];
    [self.nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlelabels.mas_bottom).offset(10);
        make.left.equalTo(self.titlelabels.mas_left).offset(2);
        make.height.mas_equalTo(20);
    }];
    [self.oldPriceLabell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nowPriceLabel.mas_centerY);
        make.left.equalTo(self.nowPriceLabel.mas_right).offset(5);
    }];
    [self.couponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nowPriceLabel.mas_bottom).offset(5);
        make.left.equalTo(self.titlelabels);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(10);
    }];
    [self.couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.couponImageView.mas_centerY);
        make.left.equalTo(self.couponImageView.mas_right).offset(0);
        make.height.mas_equalTo(10);
    }];
}
-(UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.backgroundColor=[UIColor whiteColor];
        _backImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_backImageView];
    }
    return _backImageView;
}
-(UIImageView *)picImageView
{
    if (!_picImageView) {
        _picImageView=[UIImageView new];
        _picImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self.backImageView addSubview:_picImageView];
    }
    return _picImageView;
}
-(UILabel *)titlelabels
{
    if (!_titlelabels) {
        _titlelabels=[UILabel new];
        _titlelabels.font=[UIFont fontWithName:@"PingFang SC" size:14];
        _titlelabels.textColor=[UIColor colorWithHexString:@"#666666"];
        _titlelabels.numberOfLines=2;
        [self.backImageView addSubview:_titlelabels];
    }
    return _titlelabels;
}
-(UILabel *)nowPriceLabel
{
    if (!_nowPriceLabel) {
        _nowPriceLabel = [UILabel new];
        _nowPriceLabel.font=[UIFont fontWithName:@"PingFang SC" size:14];
        _nowPriceLabel.textColor=[UIColor colorWithHexString:@"#E70014"];
        [self.backImageView addSubview:_nowPriceLabel];
    }
    return _nowPriceLabel;
}
-(UILabel *)oldPriceLabell
{
    if (!_oldPriceLabell) {
        _oldPriceLabell = [UILabel new];
        _oldPriceLabell.font=[UIFont fontWithName:@"PingFang SC" size:10];
        _oldPriceLabell.textColor=[UIColor colorWithHexString:@"#999999"];
        [self.backImageView addSubview:_oldPriceLabell];
    }
    return _oldPriceLabell;
}
-(UIImageView *)couponImageView
{
    if (!_couponImageView) {
        _couponImageView =[UIImageView new];
        _couponImageView.contentMode=UIViewContentModeScaleAspectFill;
        _couponImageView.image=[UIImage imageNamed:@"coupon_icon"];
        [self.backImageView addSubview:_couponImageView];
    }
    return _couponImageView;
}
-(UILabel *)couponPriceLabel
{
    if (!_couponPriceLabel) {
        _couponPriceLabel=[UILabel new];
        _couponPriceLabel.font=[UIFont fontWithName:@"PingFang SC" size:11];
        _couponPriceLabel.backgroundColor=[UIColor colorWithHexString:@"#E70014"];
        _couponPriceLabel.textColor=[UIColor whiteColor];
        [self.backImageView addSubview:_couponPriceLabel];
    }
    return _couponPriceLabel;
}
-(void)setModel:(WCLHomeThemeModel *)model
{
    _model=model;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.p_list_pic] placeholderImage:[UIImage imageNamed:@""]];
    self.titlelabels.text=model.p_title;
    self.nowPriceLabel.text=[NSString stringWithFormat:@"¥%@",model.p_balance];
    NSString*oldprice=[NSString stringWithFormat:@"¥%@",model.market_price];
    NSDictionary * centerAttribtDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]};
    NSMutableAttributedString * centerAttr = [[NSMutableAttributedString alloc] initWithString:oldprice attributes:centerAttribtDic];
    self.oldPriceLabell.attributedText=centerAttr;
    self.couponPriceLabel.text=model.p_cash;
}


@end
