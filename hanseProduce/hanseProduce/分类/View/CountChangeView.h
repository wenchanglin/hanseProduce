//
//  CountChangeView.h
//  manpinhy
//
//  Created by Sunsgne on 2018/6/7.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountChangeView : UIView

@property (nonatomic, assign) NSInteger currentCount;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSNumber *p_type;//1、易业商城2、精品商城3、跳蚤市场4、H单

/**
 最大可输入限制
 */
@property (nonatomic, assign) NSInteger maxInputNumber;

@property (nonatomic, copy) void(^countChangeBlock)(NSInteger count);
@property (nonatomic, copy) void(^tfBeginEditingBlock)(CGFloat keyBoardHeight);
@property (nonatomic, copy) void(^tfEndEditingBlock)(void);

@end
