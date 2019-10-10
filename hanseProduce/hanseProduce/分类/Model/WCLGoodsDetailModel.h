//
//  WCLGoodsDetailModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/28.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLGoodsDetailModel : NSObject
@property(nonatomic,strong)NSDictionary*comment;
@property(nonatomic,assign)NSInteger is_collected;
@property(nonatomic,assign)NSInteger is_size;
@property(nonatomic,strong)NSString*market_price;
@property(nonatomic,strong)NSString*p_balance;
@property(nonatomic,strong)NSString*p_cash;
@property(nonatomic,strong)NSString*p_describe;
@property(nonatomic,strong)NSArray*p_detail_pic;
@property(nonatomic,assign)NSInteger p_id;
@property(nonatomic,strong)NSString*p_list_pic;
@property(nonatomic,assign)NSInteger p_sold_num;
@property(nonatomic,assign)NSInteger p_stock;
@property(nonatomic,strong)NSString* p_title;
@property(nonatomic,assign)NSInteger p_type;
@property(nonatomic,strong)NSArray*shop;
@property(nonatomic,assign)NSInteger shop_id;
@property(nonatomic,assign)NSInteger showsale;
@property(nonatomic,strong)NSDictionary*slideshow;
@property(nonatomic,assign)NSInteger type_c;
@property(nonatomic,strong)NSString* video_url;
@end

NS_ASSUME_NONNULL_END
