//
//  AAPLSwipeTransitionDelegate.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/25.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAPLSwipeTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>
//! If this transition will be interactive, this property is set to the
//! gesture recognizer which will drive the interactivity.
@property (nonatomic, strong, nullable) UIScreenEdgePanGestureRecognizer *gestureRecognizer;

@property (nonatomic, readwrite) UIRectEdge targetEdge;
@end

NS_ASSUME_NONNULL_END
