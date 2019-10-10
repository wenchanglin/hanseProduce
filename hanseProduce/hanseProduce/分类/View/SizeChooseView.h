//
//  SizeChooseView.h
//  DZProject
//
//  Created by Sunsgne on 2018/4/8.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SizeModel.h"

typedef NS_ENUM(NSInteger, ChooseSizeType){
    ChooseSizeTypeToShopcar = 1,
    ChooseSizeTypeToOrder   = 2
};

@interface SizeChooseView : UIView

@property (nonatomic, strong) NSString *p_id;
@property (nonatomic, strong) NSString *p_pic;
@property (nonatomic, strong) NSString *p_money;

@property (nonatomic, strong) NSString *p_cash;
@property (nonatomic, strong) NSString *p_balance;
@property (nonatomic, strong) NSNumber *p_type;//1、易业商城2、精品商城3、跳蚤市场4、H单

@property (nonatomic, assign) ChooseSizeType type;

@property (nonatomic, copy) void(^finishChooseBlock)(NSString *size,NSInteger number, ChooseSizeType type, NSString *s_id, NSString *price, NSString *stock, NSString *size_cash, NSString *size_balance);

- (void)show;
- (void)hide;

@end
