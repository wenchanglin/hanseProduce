//
//  AAPLCustomPresentationController.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/25.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 居中弹窗动画控制器
@interface AAPLCustomPresentationController : UIPresentationController
// 点击弹出界面的其余部分是否可以dismiss,默认是true
@property(nonatomic, assign) BOOL touchedDismissed;
@end

NS_ASSUME_NONNULL_END
