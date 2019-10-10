//
//  WCLClassifyTwoViewModel.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLClassifyTwoViewModel.h"
#import "ProductClassify.h"
#import "WCLHomeBannerModel.h"
@implementation WCLClassifyTwoViewModel
-(instancetype)init
{
    if(self==[super init])
    {
        self.bannerArr = [NSMutableArray array];
        self.classify1Arr=[NSMutableArray array];
        self.classify2Arr=[NSMutableArray array];
    }
    return self;
}
- (NSMutableDictionary *)cell_data_dict{
    if (!_cell_data_dict) {
        _cell_data_dict = [NSMutableDictionary dictionary];
    }
    return _cell_data_dict;
}
-(RACSignal *)classifyOneWithDownPull:(BOOL)isdown WithPage:(NSInteger)page
{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    __block NSMutableArray*classifyA= [NSMutableArray array];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_ClassifyFirst_String] parameters:params finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"]integerValue]==1) {
            NSArray*arr = [ProductClassify mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (isdown){
                self.classify1Arr = arr.mutableCopy;
            }
            else
            {
                classifyA = arr.mutableCopy;
                [self.classify1Arr addObjectsFromArray:classifyA];
            }
            self.selectedIndex=0;
            [self.cell_data_dict setObject:self.classify1Arr forKey:@"classify1"];
            [subject sendNext:self.cell_data_dict];
        }else
        {
            [subject sendError:error];
        }
    }];
    return subject;
}
-(RACSignal *)classifyTwoWithDownPull:(BOOL)isdown WithPage:(NSInteger)page withcateid:(NSInteger)cateid
{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@(cateid) forKey:@"cate_id"];
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_ClassifySecond_String] parameters:params finished:^(id responseObject, NSError *error) {
//        WCLLog(@"%@",responseObject);
        if ([responseObject[@"code"]integerValue]==1) {
            [self.classify2Arr removeAllObjects];
            NSArray*picArr =[WCLHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banner"]];
            NSArray*arr = [ProductClassify mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"parent"]];
            self.classify2Arr = arr.mutableCopy;
            [self.cell_data_dict setObject:picArr forKey:@"pic"];
            [self.cell_data_dict setObject:self.classify2Arr forKey:@"classify2"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
             [subject sendError:error];
        }
    }];
    return subject;
}
-(void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
//    ProductClassify*model1= self.classify1Arr[_selectedIndex];
//    [self classifyTwoWithDownPull:YES WithPage:0 withcateid:model1.cate_id];
}
@end
