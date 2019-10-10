//
//  UIViewController+HUD.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/20.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HUD)


/**
 菊花转动
 */
-(void)showIndicator;

/**
 隐藏菊花
 */
-(void)hideIndicator;

/**
 显示信息

 @param message 信息
 */
-(void)showMessage: (nonnull NSString *)message;

/**
 显示信息1s后,block行为

 @param message 信息
 @param block block行为
 */
-(void)showMessage: (nonnull NSString *)message then: (nonnull void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
