//
//  ProductListController.h
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductListController : ViewController
@property(nonatomic,assign)ProductListStyle style;
@property(nonatomic,strong)NSString*titles;
@property(nonatomic,assign)NSInteger cid;

@end

NS_ASSUME_NONNULL_END
