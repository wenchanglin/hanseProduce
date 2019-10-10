//
//  UINavigationController+PopGestureRecognizer.h
//  YC168
//
//  Created by wen on 2017/3/30.
//  Copyright © 2017年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (PopGestureRecognizer)<UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL isPopGestureRecognizerEnable;

//@property (readwrite,getter = isViewTransitionInProgress) BOOL viewTransitionInProgress;

@end
