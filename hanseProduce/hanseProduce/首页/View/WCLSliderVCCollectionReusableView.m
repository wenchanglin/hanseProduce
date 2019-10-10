//
//  WCLSliderVCCollectionReusableView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/25.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLSliderVCCollectionReusableView.h"
#import "WCLHomeCateModel.h"
#import "WCLHomeThreeLevelCollectionVC.h"
@interface WCLSliderVCCollectionReusableView()
@property(nonatomic,strong)NSMutableArray*cate_idArr;
@end
@implementation WCLSliderVCCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=VIEW_BASE_COLOR;
        [self.titleLabels mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(12);
            make.height.mas_equalTo(21);
        }];
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabels.mas_centerY);
            make.right.mas_equalTo(-12);
        }];
    }
    return self;
}
-(UILabel *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = [UILabel new];
        _titleLabels.text=@"商品主题场";
        _titleLabels.font=[UIFont fontWithName:@"PingFang SC" size:15];
        _titleLabels.textColor=[UIColor colorWithHexString:@"#333333"];
        [self addSubview:_titleLabels];
    }
    return _titleLabels;
}
-(UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn=[UIButton new];
        [_moreBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        _moreBtn.titleLabel.font=[UIFont fontWithName:@"PingFang SC" size:14];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"rightjiantou"] forState:UIControlStateNormal];
        [_moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -_moreBtn.imageView.bounds.size.width-30, 0, _moreBtn.imageView.bounds.size.width)];
        [_moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _moreBtn.titleLabel.bounds.size.width+25, 0, -_moreBtn.titleLabel.bounds.size.width)];
        [self addSubview:_moreBtn];
    }
    return _moreBtn;
}

@end
