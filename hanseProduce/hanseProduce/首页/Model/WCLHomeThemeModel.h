//
//  WCLHomeThemeModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeThemeModel : NSObject
@property(nonatomic,strong)NSString* market_price;
@property(nonatomic,strong)NSString* p_balance;
@property(nonatomic,strong)NSString*p_cash;
@property(nonatomic,strong)NSString*p_describe;
@property(nonatomic,assign)NSInteger p_id;
@property(nonatomic,strong)NSString*p_list_pic;
@property(nonatomic,assign)NSInteger p_sold_num;
@property(nonatomic,assign)NSInteger p_stock;
@property(nonatomic,strong)NSString*p_title;
@property(nonatomic,assign)NSInteger p_type;
@end

NS_ASSUME_NONNULL_END
