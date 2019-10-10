//
//  UIViewController+SwipeTransition.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/25.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SwipeTransition)

-(void)customSwipePresentViewController: (nonnull UIViewController *)destination withGesture: (nullable UIScreenEdgePanGestureRecognizer *)gesture;

-(void)customSwipeDismissWithGesture: (nullable UIScreenEdgePanGestureRecognizer *)gesture;

-(void)resetSwipeDelegate;
@end

NS_ASSUME_NONNULL_END
