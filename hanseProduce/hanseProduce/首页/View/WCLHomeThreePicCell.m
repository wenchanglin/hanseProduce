//
//  WCLHomeThreePicCell.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/24.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeThreePicCell.h"
#import "WCLHomeThreePicModel.h"
@implementation WCLHomeThreePicCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(12);
            make.width.mas_equalTo(YBLWidth_Scale*172);
            make.height.mas_equalTo(YBLWidth_Scale*208);
        }];
        [self.firstImageView layoutIfNeeded];
        [self.firstImageView addCornerRadius:6 rectCorner:UIRectCornerAllCorners];
        
        [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.firstImageView.mas_right).offset(10);
            make.right.mas_equalTo(-12);
            make.height.mas_equalTo(YBLWidth_Scale*99);
        }];
        [self.secondImageView layoutIfNeeded];
        [self.secondImageView addCornerRadius:6 rectCorner:UIRectCornerAllCorners];
        
        [self.threeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.secondImageView.mas_bottom).offset(10);
            make.left.height.right.equalTo(self.secondImageView);
        }];
        [self.threeImageView layoutIfNeeded];
        [self.threeImageView addCornerRadius:6 rectCorner:UIRectCornerAllCorners];
        NSArray<UIImageView*> *ivs = [NSArray arrayWithObjects:self.firstImageView, self.secondImageView, self.threeImageView, nil];
               for (UIImageView *v in ivs) {
                   UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImg:)];
                   [v setUserInteractionEnabled:true];
                   [v addGestureRecognizer:t];
               }
    }
    return self;
}
-(void)clickImg: (UITapGestureRecognizer *)sender {
    UIView *v = sender.view;
    if (!v) {
        return;
    }
    if (v == self.firstImageView) {
        [self handleTap:0];
        return;
    }
    if (v == self.secondImageView) {
        [self handleTap:1];
        return;
    }
    if (v == self.threeImageView) {
        [self handleTap:2];
        return;
    }
}

-(void)handleTap: (NSInteger)index {
    if (self.ThreeImageTapBlock) {
        self.ThreeImageTapBlock(index);
    }
}
-(UIImageView *)firstImageView
{
    if (!_firstImageView) {
        _firstImageView=[UIImageView new];
        _firstImageView.backgroundColor=[UIColor whiteColor];
        _firstImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_firstImageView];
    }
    return _firstImageView;
}
-(UIImageView *)secondImageView
{
    if (!_secondImageView) {
        _secondImageView=[UIImageView new];
        _secondImageView.backgroundColor=[UIColor whiteColor];
        _secondImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_secondImageView];
    }
    return _secondImageView;
}
-(UIImageView *)threeImageView
{
    if (!_threeImageView) {
        _threeImageView=[UIImageView new];
        _threeImageView.backgroundColor=[UIColor whiteColor];
        _threeImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_threeImageView];
    }
    return _threeImageView;
}
-(void)setThreeArr:(NSMutableArray *)threeArr
{
    _threeArr=threeArr;
   if(_threeArr.count==3)
   {
       WCLHomeThreePicModel*model1 = _threeArr[0];
          WCLHomeThreePicModel*model2 = _threeArr[1];
          WCLHomeThreePicModel*model3 = _threeArr[2];
          [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:model1.img] placeholderImage:[UIImage imageNamed:@""]];
          [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:model2.img] placeholderImage:[UIImage imageNamed:@""]];
          [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:model3.img] placeholderImage:[UIImage imageNamed:@""]];
   }

}
@end
