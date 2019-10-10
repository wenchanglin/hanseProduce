//
//  ClassifyTwoCell.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ClassifyTwoCell.h"

@implementation ClassifyTwoCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.label];
    }
    return self;
}
-(void)setTitle:(NSString *)title imageUrl:(NSString *)url {
    self.label.text = title;
    [self.imgView showImgUrl:url placeholder:NULL];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.width = self.contentView.width * 0.7;
    self.imgView.height = self.contentView.width * 0.7;
    self.imgView.top = YBLWidth_Scale*5;
    self.imgView.centerX = self.contentView.width * 0.5;
    
    self.label.width = self.contentView.width;
    self.label.height = YBLWidth_Scale*(15);
    self.label.centerX = self.contentView.width * 0.5;
    self.label.top = self.imgView.bottom + 5;
}

-(UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}

-(UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = kRegularFont(YBLWidth_Scale*12);
        _label.textColor = [UIColor f6];
    }
    return _label;
}
@end
