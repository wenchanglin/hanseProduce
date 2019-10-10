//
//  WCLGoodsDetailViewModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/28.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCLGoodsDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WCLGoodsDetailViewModel : NSObject
@property(nonatomic,strong)NSMutableArray*DataArr;
@property(nonatomic,strong)NSMutableArray*bannerArr;
@property(nonatomic,strong)NSMutableDictionary*cell_data_dict;

-(RACSignal *)CateDetailDataWithDownPull:(BOOL)isdown Withpid:(NSInteger)pid;

@end

NS_ASSUME_NONNULL_END
