//
//  HomeHeaderView1.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/27.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()
@property(nonatomic, strong) CALayer *bgLayer;
@end

@implementation HomeHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.canvas;
        [self.layer insertSublayer:self.bgLayer above:0];
        [self addSubview:self.carouslView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.carouslView.width = self.width - YBLWidth_Scale*(24);
    self.carouslView.height = HomeHeaderView.carouselViewHeight;
    self.carouslView.centerX = self.width * 0.5;
    self.carouslView.bottom = self.height;
    
    self.bgLayer.width = self.width;
    self.bgLayer.height = YBLWidth_Scale*(454);
    self.bgLayer.bottom = self.carouslView.bottom - HomeHeaderView.bglayerBottom;
    if (self.carouseColor == nil) {
        UIImage *img = [UIImage linerThemeImageWithSize:self.bgLayer.size];
        self.bgLayer.contents = (__bridge id _Nullable)(img.CGImage);
    }
}

-(void)setCarouseColor:(NSString *)carouseColor {
    _carouseColor = carouseColor;
    if (self.carouseColor) {
        UIColor *c = [UIColor py_colorWithHexString:self.carouseColor];
        self.bgLayer.contents = (__bridge id _Nullable)([[UIImage imageWithColor:c] CGImage]);
    }
}

+(CGFloat)carouselViewHeight {
    return YBLWidth_Scale*140;
}

+(CGFloat)bglayerBottom {
    return YBLWidth_Scale*(50);
}

+(CGFloat)bglayerOffsetCarouseTop {
    return HomeHeaderView.carouselViewHeight - HomeHeaderView.bglayerBottom;
}

-(CALayer *)bgLayer {
    if (_bgLayer == nil) {
        _bgLayer = [[CALayer alloc] init];
    }
    return _bgLayer;
}

-(CarouselView *)carouslView {
    if (_carouslView == nil) {
        _carouslView = [[CarouselView alloc] initWithFrame:CGRectZero];
        _carouslView.backgroundColor = UIColor.canvas;
        _carouslView.layer.cornerRadius = 8;
        _carouslView.clipsToBounds = true;
    }
    return _carouslView;
}

@end
