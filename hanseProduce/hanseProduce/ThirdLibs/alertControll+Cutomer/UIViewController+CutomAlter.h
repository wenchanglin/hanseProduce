//
//  UIViewController+CutomAlter.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/25.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CutomAlter)<UIViewControllerTransitioningDelegate>

-(void)customCenterAlterViewController: (nonnull UIViewController *)destination;

/// 居中弹出目标控制器
/// @param destination 目标控制器
/// @param touchedDismiss 点击目标控制器其余部分是否dismiss
-(void)customCenterAlterViewController: (nonnull UIViewController *)destination touchedCoverDismiss: (BOOL)touchedDismiss;
@end

NS_ASSUME_NONNULL_END
