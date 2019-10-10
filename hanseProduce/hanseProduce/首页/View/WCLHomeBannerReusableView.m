//
//  WCLHomeBannerReusableView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/23.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeBannerReusableView.h"
#import "WCLHomeBannerModel.h"
@implementation WCLHomeBannerReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithHexString:@"#F6F6F6"];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

    }
    return self;
}
-(HomeHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[HomeHeaderView alloc] init];
        _headerView.carouslView.delegate=self;
        [self addSubview:_headerView];
    }
    return _headerView;
}
-(NSArray<NSString *> *)dataSourceForCarouselView:(CarouselView *)carouselView {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [self.bannerArr enumerateObjectsUsingBlock:^(WCLHomeBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isVideo) {
            [arr addObject:obj.video];
        } else {
            [arr addObject:obj.img];
        }
    }];
    return arr;
}

-(NSArray<NSNumber *> *)dataSourceIsMovieForCarouselView:(CarouselView *)carouselView {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [self.bannerArr enumerateObjectsUsingBlock:^(WCLHomeBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:[NSNumber numberWithBool:obj.isVideo]];
    }];
    return arr;
}

-(void)didClickImageAtCarouselView:(CarouselView *)carouselView atIndex:(NSInteger)idx {
    WCLHomeBannerModel *c = self.bannerArr[idx];
    if (c.isVideo) {
        return;
    }
    [self handleActionForCarousel:c];
}

-(void)carouselView:(CarouselView *)carouselView didScrollToIndex:(NSInteger)idx {
    WCLHomeBannerModel *c = self.bannerArr[idx];
    self.headerView.carouseColor = c.color_value;
}

-(void)handleActionForCarousel: (WCLHomeBannerModel*)c {
    WEAK
    [WCLHomeBannerModel getControllerForStyle:c.style itemid:c.itemid withBlock:^(UIViewController * _Nonnull vc, BOOL isPush) {
        STRONG
        self.bannerClickItemBlock(isPush, vc);
    }];
}

-(void)setBannerArr:(NSMutableArray *)bannerArr
{
    _bannerArr = bannerArr;
    [self.headerView.carouslView reload];
}

@end
