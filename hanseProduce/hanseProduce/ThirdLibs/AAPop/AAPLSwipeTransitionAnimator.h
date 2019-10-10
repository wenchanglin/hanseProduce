//
//  AAPLSwipeTransitionAnimator.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/25.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAPLSwipeTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;

@property (nonatomic, readwrite) UIRectEdge targetEdge;
@end

NS_ASSUME_NONNULL_END
