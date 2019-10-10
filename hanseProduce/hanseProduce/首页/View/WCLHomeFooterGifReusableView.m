//
//  WCLHomeFooterGifReusableView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/24.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeFooterGifReusableView.h"


@implementation WCLHomeFooterGifReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=VIEW_BASE_COLOR;
        [self.gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(2);
            make.bottom.right.mas_equalTo(-8);
        }];
    }
    return self;
}
-(YYAnimatedImageView *)gifImageView
{
    if (!_gifImageView) {
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        _gifImageView=imageView;
    }
    return _gifImageView;
}
-(void)setModel:(WCLHomeThreePicModel *)model
{
    _model=model;
    [_gifImageView yy_setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"default"]];

}
@end
