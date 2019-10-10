//
//  WCLHomeCateModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/25.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeCateModel : NSObject
@property(nonatomic,assign)NSInteger p_id;
@property(nonatomic,assign)NSInteger p_type;
@property(nonatomic,strong)NSString* p_list_pic;
@property(nonatomic,strong)NSString*p_title;
@property(nonatomic,assign)NSInteger p_sold_num;
@property(nonatomic,strong)NSString*p_cash;
@property(nonatomic,strong)NSString* p_balance;
@property(nonatomic,strong)NSString* market_price;
@end
@interface WCLHomeCateTitleModel : NSObject
@property(nonatomic,strong)NSString* cate_title;
@property(nonatomic,assign)NSInteger cate_id;
@end
NS_ASSUME_NONNULL_END
