//
//  WCLGoodsDetailViewModel.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/28.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLGoodsDetailViewModel.h"
@implementation WCLGoodsDetailViewModel
-(instancetype)init
{
    if (self==[super init]) {
        self.DataArr = [NSMutableArray array];
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
-(RACSignal *)CateDetailDataWithDownPull:(BOOL)isdown Withpid:(NSInteger)pid
{
    RACSubject * subject = [RACSubject subject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    __block NSMutableArray*threePicA = [NSMutableArray array];
//    __block NSMutableArray*gifA = [NSMutableArray array];
    [params setObject:@(pid) forKey:@"p_id"];
    WEAK
    [[wclNetTool sharedTools]request:GET urlString:[MoreUrlInterface URL_CateDetailData_String] parameters:params finished:^(id responseObject, NSError *error) {
//        WCLLog(@"%@",responseObject);
        STRONG
        if ([responseObject[@"code"]integerValue]==1) {
            WCLGoodsDetailModel*mainModel = [WCLGoodsDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            if (mainModel.video_url.length==0||[mainModel.video_url isEqualToString:@""]) {
                
            }
            else
            {
                NSDictionary *dic = @{@"isMovie": @"1", @"url": mainModel.video_url};
                [self.bannerArr addObject:dic];
            }
            NSArray*picArrs = mainModel.p_detail_pic;
            [picArrs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString*url=obj;
                NSDictionary *dic = @{@"isMovie": @"0", @"url": url};
                [self.bannerArr addObject:dic];
            }];
            [self.cell_data_dict setObject:self.bannerArr forKey:@"banner"];
            [self.cell_data_dict setObject:mainModel forKey:@"mainModel"];
            [subject sendNext:self.cell_data_dict];
        }
        else
        {
            if ([responseObject[@"errorCode"] isEqualToString:@"30001"]) {
                [subject sendNext:@"商品不存在"];

            }else{
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errorMsg"]];
                
            }
        }
    }];
    return subject;
}
@end
