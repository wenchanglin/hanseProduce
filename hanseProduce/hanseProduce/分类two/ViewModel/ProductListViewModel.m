//
//  ProductListViewModel.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ProductListViewModel.h"
#import "WCLHomeThemeModel.h"
#import "WCLHomeBannerModel.h"
@implementation ProductListViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.classifyArr=[NSMutableArray array];
        self.bannerArr=[NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)ProductDataListWithDownPull:(BOOL)isdown WithPage:(NSInteger)page withCatetype:(NSInteger)catetype
{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*gifA = [NSMutableArray array];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@(catetype) forKey:@"type"];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_ProductListData_String] parameters:params finished:^(id responseObject, NSError *error) {
        WCLLog(@"%@,%@",responseObject,error);
        if ([responseObject[@"code"]integerValue]==1) {
            if (isdown){
                self.classifyArr = [WCLHomeThemeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"product"]];
            }
            else
            {
                gifA=[WCLHomeThemeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"product"]];
                [self.classifyArr addObjectsFromArray:gifA];
            }
            self.bannerArr = [WCLHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"carousel"]];
            [self.cell_data_dict setObject:self.classifyArr forKey:@"classifyArr"];
            [self.cell_data_dict setObject:self.bannerArr forKey:@"banner"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            [subject sendError:error];
        }
    }];
    return subject;
}
-(RACSignal *)ProductDataWithDownPull:(BOOL)isdown WithPage:(NSInteger)page withCateId:(NSInteger)cateid sorttype:(NSInteger)sorttype withCatetype:(NSInteger)catetype
{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*gifA = [NSMutableArray array];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@(cateid) forKey:@"cate_id"];
    [params setObject:@(sorttype) forKey:@"by"];
    [params setObject:@(catetype) forKey:@"type"];
    
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_ProductData_String] parameters:params finished:^(id responseObject, NSError *error) {
        //        WCLLog(@"%@,%@",responseObject,error);
        if ([responseObject[@"code"]integerValue]==1) {
            if (isdown){
                self.classifyArr = [WCLHomeThemeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }
            else
            {
                gifA=[WCLHomeThemeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.classifyArr addObjectsFromArray:gifA];
            }
            [self.cell_data_dict setObject:self.classifyArr forKey:@"classifyArr"];
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
