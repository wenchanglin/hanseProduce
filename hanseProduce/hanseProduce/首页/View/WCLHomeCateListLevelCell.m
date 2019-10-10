//
//  WCLHomeCateListLevelCell.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/26.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeCateListLevelCell.h"

@implementation WCLHomeCateListLevelCell
-(void)setupLayout
{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(5);
        make.bottom.right.mas_equalTo(-5);
    }];
    [self.backImageView layoutIfNeeded];
    [self.backImageView addCornerRadius:6 rectCorner:UIRectCornerAllCorners];
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
@end
