//
//  SizeModel.h
//  DZProject
//
//  Created by Sunsgne on 2018/4/8.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SizeModel : NSObject

@property (nonatomic, strong) NSNumber *attr_id;
@property (nonatomic, strong) NSString *attr_title;
@property (nonatomic, strong) NSArray *portoties;

@end

@interface SizePortotiesModel : NSObject

@property (nonatomic, strong) NSNumber *attr_val_id;
@property (nonatomic, strong) NSString *attr_val_name;
@property (nonatomic, strong) NSString *bind_id;

//是否不可点击
@property (nonatomic, assign) BOOL forbiddin;

@end

@interface AllSizeCanChooseModel : NSObject

@property (nonatomic, strong) NSString *size_consume_score;
@property (nonatomic, strong) NSNumber *size_id;
@property (nonatomic, strong) NSString *size_img;
@property (nonatomic, strong) NSString *size_m_score;
@property (nonatomic, strong) NSArray *size_portoties;
@property (nonatomic, strong) NSNumber *size_stock;
@property (nonatomic, strong) NSString *size_t_score;
@property (nonatomic, strong) NSString *size_ticket_score;
@property (nonatomic, strong) NSString *size_cash;
@property (nonatomic, strong) NSString *size_balance;
@property (nonatomic, strong) NSString *size_title;

@end
