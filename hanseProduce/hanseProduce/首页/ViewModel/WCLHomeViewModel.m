//
//  HomeViewModel.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeViewModel.h"
#import "WCLHomeThreePicModel.h"
#import "WCLHomeBannerModel.h"
#import "WCLHomeThemeModel.h"
#import "WCLHomeClassifyModel.h"
#import "WCLHotDataModel.h"
#import "WCLHomeCateModel.h"
@implementation WCLHomeViewModel
-(instancetype)init{
    if (self==[super init]) {
        self.bannerArr = [NSMutableArray array];
        self.threePicArr=[NSMutableArray array];
        self.gifArr=[NSMutableArray array];
        self.themeArr = [NSMutableArray array];
        self.classifyArr=[NSMutableArray array];
        self.hotDataArr=[NSMutableArray array];
        self.hotH5Arr=[NSMutableArray array];
        self.sliderArr=[NSMutableArray array];
        self.sliderTitleArr=[NSMutableArray array];
        self.slideridArr=[NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)homeThreePicWithDownPull:(BOOL)isdown WithPage:(NSInteger)page
{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*threePicA = [NSMutableArray array];
    __block NSMutableArray*gifA = [NSMutableArray array];
    
    [params setObject:@(page) forKey:@"page"];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_HomeThreePic_String] parameters:params finished:^(id responseObject, NSError *error) {
//                        WCLLog(@"%@,%@",responseObject,error);
        if ([responseObject[@"code"]integerValue]==1) {
            if (isdown){
                self.threePicArr = [WCLHomeThreePicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"tree"]];
                self.gifArr =[WCLHomeThreePicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"two"]];
            }
            else
            {
                threePicA =[WCLHomeThreePicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"tree"]];
                gifA=[WCLHomeThreePicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"two"]];
                [self.gifArr addObjectsFromArray:gifA];
                [self.threePicArr addObjectsFromArray:threePicA];
            }
            [self.cell_data_dict setObject:self.threePicArr forKey:@"threepic"];
            [self.cell_data_dict setObject:self.gifArr forKey:@"homegif"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendError:error];
        }
    }];
    return subject;
}
-(RACSignal *)HomeDataWithDownPull:(BOOL)isdown WithPage:(NSInteger)page
{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*bannerA = [NSMutableArray array];
    __block NSMutableArray*themeA = [NSMutableArray array];
    //    [params setObject:@(page) forKey:@"page"];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_HomeData_String] parameters:params finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"]integerValue]==1) {
            if (isdown){
                self.bannerArr = [WCLHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"carousel"]];
                self.themeArr =[WCLHomeThemeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"boutique"]];
            }
            else
            {
                bannerA =[WCLHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"carousel"]];
                themeA = [WCLHomeThemeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"boutique"]];
                [self.bannerArr addObjectsFromArray:bannerA];
                [self.themeArr addObjectsFromArray:themeA];
            }
            [self.cell_data_dict setObject:self.bannerArr forKey:@"homebanner"];
            [self.cell_data_dict setObject:self.themeArr forKey:@"hometheme"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendError:error];
        }
    }];
    return subject;
}
-(RACSignal *)HomeClassifyWithDownPull:(BOOL)isdown WithPage:(NSInteger)page
{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*classifyA = [NSMutableArray array];
    [params setObject:@(page) forKey:@"page"];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_HomeClassify_String] parameters:params finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"]integerValue]==1) {
            NSMutableArray*sortArr = [WCLHomeClassifyModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            NSArray*arr= [sortArr sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
                WCLHomeClassifyModel*ob1= obj1;
                WCLHomeClassifyModel*ob2=obj2;
                if (ob1.cate_sort<ob2.cate_sort) {
                    return  NSOrderedAscending;
                }
                return NSOrderedDescending;
            }];
//            WCLLog(@"%@",arr);
            if (isdown){
                self.classifyArr = arr.mutableCopy;
            }
            else
            {
                classifyA = arr.mutableCopy;
                [self.classifyArr addObjectsFromArray:classifyA];
            }
            [self.cell_data_dict setObject:self.classifyArr forKey:@"homeclassify"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendError:error];
        }
    }];
    return subject;
}
-(RACSignal *)HomeHotDataWithDownPull:(BOOL)isdown WithPage:(NSInteger)page{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*hoth5A = [NSMutableArray array];
    __block NSMutableArray*hotA = [NSMutableArray array];
    [params setObject:@(3) forKey:@"size"];
    [params setObject:@(3) forKey:@"explosion"];
    [params setObject:@(page) forKey:@"page"];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_HomeHotData_String] parameters:params finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"]integerValue]==1) {
            if (isdown){
                self.hotDataArr = [WCLHotDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"boutique"]];
                self.hotH5Arr = [WCLHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"carousel"]];
            }
            else
            {
                hotA =[WCLHotDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"boutique"]];
                hoth5A=[WCLHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"carousel"]];
                [self.hotDataArr addObjectsFromArray:hotA];
                [self.hotH5Arr addObjectsFromArray:hoth5A];
            }
            [self.cell_data_dict setObject:self.hotDataArr forKey:@"homehotdata"];
            [self.cell_data_dict setObject:self.hotH5Arr forKey:@"homehoth5"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendError:error];
        }
    }];
    return subject;
}
-(RACSignal *)HomeSliderDataWithDownPull:(BOOL)isdown WithCid:(NSInteger)cid withPage:(NSInteger)page{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*sliderA = [NSMutableArray array];
//    __block NSMutableArray*hotA = [NSMutableArray array];
    [params setObject:@(cid) forKey:@"c_id"];
    [params setObject:@(page) forKey:@"page"];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_HomeSliderTitle_String] parameters:params finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"]integerValue]==1) {
            if (isdown){
                self.sliderArr = [WCLHomeCateModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"product"]];
            }
            else
            {
                sliderA = [WCLHomeCateModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"product"]];
                [self.sliderArr addObjectsFromArray:sliderA];
            }
            [self.cell_data_dict setObject:self.sliderArr forKey:@"homeslider"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendError:error];
        }
    }];
    return subject;
}
-(RACSignal *)HomeSliderTitleWithDownPull:(BOOL)isdown WithCid:(NSInteger)cid{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*sliderTitleA = [NSMutableArray array];
        __block NSMutableArray*slideridA = [NSMutableArray array];
    [params setObject:@(cid) forKey:@"c_id"];
    [params setObject:@(0) forKey:@"page"];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_HomeSliderTitle_String] parameters:params finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"]integerValue]==1) {
            if (isdown){
//                WCLLog(@"%@::%@",responseObject,error);
                NSArray*arrs = [WCLHomeCateTitleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"cate"]];
                for (WCLHomeCateTitleModel*model in arrs) {
                    [self.sliderTitleArr addObject:model.cate_title];
                    [self.slideridArr addObject:@(model.cate_id)];
                }
            }
            else
            {
                NSArray*arrsss = [WCLHomeCateTitleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"cate"]];
                for (WCLHomeCateTitleModel*model in arrsss) {
                    [sliderTitleA addObject:model.cate_title];
                    [slideridA addObject:@(model.cate_id)];
                }
                [self.sliderTitleArr addObjectsFromArray:sliderTitleA];
                [self.slideridArr addObjectsFromArray:slideridA];
            }
            
            [self.cell_data_dict setObject:self.sliderTitleArr forKey:@"homeslidertitle"];
            [self.cell_data_dict setObject:self.slideridArr forKey:@"homecateid"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendError:error];
        }
    }];
    return subject;
}

@end
