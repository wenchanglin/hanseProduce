//
//  WCLClassifyTwoViewModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLClassifyTwoViewModel : NSObject
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic,strong) NSMutableArray * bannerArr;
@property(nonatomic,strong) NSMutableArray * classify2Arr;
@property(nonatomic,strong) NSMutableArray * classify1Arr;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
-(RACSignal *)classifyOneWithDownPull:(BOOL)isdown WithPage:(NSInteger)page;
-(RACSignal *)classifyTwoWithDownPull:(BOOL)isdown WithPage:(NSInteger)page withcateid:(NSInteger)cateid;
@end

NS_ASSUME_NONNULL_END
