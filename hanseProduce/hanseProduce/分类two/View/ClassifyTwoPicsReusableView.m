//
//  ClassifyTwoPicsReusableView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/10.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ClassifyTwoPicsReusableView.h"
#import "WCLHomeBannerModel.h"
@implementation ClassifyTwoPicsReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self.carouseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
-(CarouselView *)carouseView {
    if (_carouseView == nil) {
        _carouseView = [[CarouselView alloc] init];
        _carouseView.delegate=self;
        [self addSubview:_carouseView];
    }
    return _carouseView;
}
-(void)setPicsArr:(NSMutableArray *)picsArr
{
    _picsArr=picsArr;
    [self.carouseView reload];
}
-(NSArray<NSString *> *)dataSourceForCarouselView:(CarouselView *)carouselView
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
       [self.picsArr enumerateObjectsUsingBlock:^(WCLHomeBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    [self.picsArr enumerateObjectsUsingBlock:^(WCLHomeBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:[NSNumber numberWithBool:obj.isVideo]];
    }];
    return arr;
}

-(void)didClickImageAtCarouselView:(CarouselView *)carouselView atIndex:(NSInteger)idx {
    WCLHomeBannerModel *c = self.picsArr[idx];
    if (c.isVideo) {
        return;
    }
    [self handleActionForCarousel:c];
}
-(void)handleActionForCarousel: (WCLHomeBannerModel*)c {
    WEAK
    [WCLHomeBannerModel getControllerForStyle:c.style itemid:c.itemid withBlock:^(UIViewController * _Nonnull vc, BOOL isPush) {
        STRONG
        self.bannerClickItemBlock(isPush, vc);
    }];
}

@end
