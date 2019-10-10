//
//  HomeViewModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeViewModel : NSObject
@property(nonatomic,strong) NSMutableArray * bannerArr;
@property(nonatomic,strong) NSMutableArray * threePicArr;
@property(nonatomic,strong) NSMutableArray * classifyArr;
@property(nonatomic,strong) NSMutableArray * hotDataArr;
@property(nonatomic,strong) NSMutableArray * hotH5Arr;
@property(nonatomic,strong) NSMutableArray * gifArr;
@property(nonatomic,strong) NSMutableArray * themeArr;
@property(nonatomic,strong) NSMutableArray * sliderArr;
@property(nonatomic,strong) NSMutableArray * sliderTitleArr;
@property(nonatomic,strong) NSMutableArray * slideridArr;


@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
-(RACSignal *)homeThreePicWithDownPull:(BOOL)isdown WithPage:(NSInteger)page;
-(RACSignal*)HomeDataWithDownPull:(BOOL)isdown WithPage:(NSInteger)page;
-(RACSignal*)HomeClassifyWithDownPull:(BOOL)isdown WithPage:(NSInteger)page;
-(RACSignal*)HomeHotDataWithDownPull:(BOOL)isdown WithPage:(NSInteger)page;
-(RACSignal *)HomeSliderDataWithDownPull:(BOOL)isdown WithCid:(NSInteger)cid withPage:(NSInteger)page;
-(RACSignal *)HomeSliderTitleWithDownPull:(BOOL)isdown WithCid:(NSInteger)cid;

@end

NS_ASSUME_NONNULL_END
