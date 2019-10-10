//
//  ProductListViewModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductListViewModel : NSObject
@property(nonatomic,strong) NSMutableArray * classifyArr;
@property(nonatomic,strong)NSMutableArray*bannerArr;
@property (nonatomic, strong) NSMutableDictionary *cell_data_dict;
/// 。。。
/// @param isdown 上拉
/// @param page 分页
/// @param cateid 分类id
/// @param sorttype 排序类型(1 综合  2 热销  3 价格)
/// @param catetype 分类类型(1 父类 2 子类)
-(RACSignal *)ProductDataWithDownPull:(BOOL)isdown WithPage:(NSInteger)page withCateId:(NSInteger)cateid sorttype:(NSInteger)sorttype withCatetype:(NSInteger)catetype;

-(RACSignal *)ProductDataListWithDownPull:(BOOL)isdown WithPage:(NSInteger)page  withCatetype:(NSInteger)catetype;

@end

NS_ASSUME_NONNULL_END
