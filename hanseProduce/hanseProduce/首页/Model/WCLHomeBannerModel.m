//
//  WCLHomeBannerModel.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeBannerModel.h"
#import "WCLGoodsDetailVC.h"
#import "ProductListController.h"
@implementation WCLHomeBannerModel
-(BOOL)isVideo
{
    return ![self.video isEqualToString:@""];
}
-(void)setType:(NSString *)type
{
    _type=type;
    if (type) {
        if ([type isEqualToString:@"goods"]) {
            self.style = CarouselStyleGoods;
        } else if ([type isEqualToString:@"link"]) {
            self.style = CarouselStyleLink;
        } else if ([type isEqualToString:@"fruit_game"]) {
            self.style = CarouselStyleOther;
        } else if ([type isEqualToString:@"cate"]) {
            self.style = CarouselStyleCate;
        } else if ([type isEqualToString:@"novice"]) {
            self.style = CarouselStyleNovice;
        } else if ([type isEqualToString:@"bag"]) {
            self.style = CarouselStyleGift;
        } else {
            self.style = CarouselStyleOther;
        }
    } else {
        self.style = CarouselStyleOther;
    }
}
+(void)getControllerForStyle:(CarouselStyle)style itemid: (NSString*)iid withBlock: (void(^)(UIViewController *vc, BOOL isPush))block {
    UIViewController *vc;
    BOOL isP = true;
    switch (style) {
        case CarouselStyleGoods:
        {
            WCLGoodsDetailVC *v = [[WCLGoodsDetailVC alloc] init];
            v.p_id = [iid integerValue];
            vc = v;
            isP = false;
        }
            break;
        case CarouselStyleLink:
        {
            NSURL *url = [NSURL URLWithString:iid];
            if (url) {
//                vc = [[WebController alloc] initWithUrl:url];
                isP = false;
            }
        }
            break;
        case CarouselStyleCate:
        {
        NSInteger idd = [iid integerValue]?:0;
//            vc = [[SecondClassifyController alloc] initWithParentId:idd];
            [vc setHidesBottomBarWhenPushed:true];
            isP = true;
        }
            break;
    case CarouselStyleNovice:
        {
            ProductListController* dvc = [[ProductListController alloc] init];
            vc=dvc;
            dvc.style=ProductListStyleNew;
            dvc.cid=0;
            isP = true;
        }
            break;
        case CarouselStyleGift:
        {
            ProductListController* dvc = [[ProductListController alloc] init];
            vc=dvc;
            dvc.style=ProductListStyleGift;
            dvc.cid=0;
            isP = true;
        }
            break;
        default:
            break;
    }
    if (vc && block) {
        block(vc, isP);
    }
}
Description
@end
