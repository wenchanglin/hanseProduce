//
//  UIViewController+SwipeTransition.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/25.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "UIViewController+SwipeTransition.h"
#import "AAPLSwipeTransitionDelegate.h"
#import <objc/runtime.h>
static const char swipeTransitionDelegateKey;

@implementation UIViewController (SwipeTransition)

-(void)customSwipePresentViewController: (nonnull UIViewController *)destination withGesture: (nullable UIScreenEdgePanGestureRecognizer *)gesture {
    if (!destination) {
        return;
    }
    self.swipeTransitionDelegate.targetEdge = UIRectEdgeRight;
    destination.transitioningDelegate = self.swipeTransitionDelegate;
    destination.modalPresentationStyle = UIModalPresentationFullScreen;
    if ([gesture isKindOfClass:UIGestureRecognizer.class]) {
        self.swipeTransitionDelegate.gestureRecognizer = gesture;
    } else {
        self.swipeTransitionDelegate.gestureRecognizer = nil;
    }
    [self presentViewController:destination animated:true completion:nil];
}

-(void)customSwipeDismissWithGesture: (nullable UIScreenEdgePanGestureRecognizer *)gesture {
    UINavigationController *navi = self.navigationController;
    if (navi) {
        if ([navi.transitioningDelegate isKindOfClass:AAPLSwipeTransitionDelegate.class]) {
            AAPLSwipeTransitionDelegate *td = navi.transitioningDelegate;
            if ([gesture isKindOfClass:UIGestureRecognizer.class]) {
                td.gestureRecognizer = gesture;
            } else {
                td.gestureRecognizer = nil;
            }
            td.targetEdge = UIRectEdgeLeft;
        }
        [navi dismissViewControllerAnimated:true completion:nil];
        return;
    }
    if (![self.transitioningDelegate isKindOfClass:AAPLSwipeTransitionDelegate.class]) {
        [self dismissViewControllerAnimated:true completion:nil];
        return;
    }
    AAPLSwipeTransitionDelegate *td = self.transitioningDelegate;
    if ([gesture isKindOfClass:UIGestureRecognizer.class]) {
        td.gestureRecognizer = gesture;
    } else {
        td.gestureRecognizer = nil;
    }
    td.targetEdge = UIRectEdgeLeft;
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)resetSwipeDelegate {
    self.swipeTransitionDelegate.targetEdge = UIRectEdgeLeft;
    self.swipeTransitionDelegate.gestureRecognizer = nil;
}

-(AAPLSwipeTransitionDelegate *)swipeTransitionDelegate {
    AAPLSwipeTransitionDelegate *d = objc_getAssociatedObject(self, &swipeTransitionDelegateKey);
    if (d) {
        return d;
    }
    AAPLSwipeTransitionDelegate *dd = [[AAPLSwipeTransitionDelegate alloc] init];
    objc_setAssociatedObject(self, &swipeTransitionDelegateKey, dd, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return dd;
}

@end
