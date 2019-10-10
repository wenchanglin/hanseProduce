//
//  UIApplication+Utils.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/28.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "UIApplication+Utils.h"

@implementation UIApplication (Utils)

+(UIViewController *)topViewController {
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *vc = [self currentViewControllerFrom:root];
    return vc;
}

+ (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [self currentViewControllerFrom:[((UINavigationController *) viewController) visibleViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [self currentViewControllerFrom:[((UITabBarController *) viewController) selectedViewController]];
    } else {
        if (viewController.presentedViewController) {
            return [self currentViewControllerFrom:viewController.presentedViewController];
        } else {
            return viewController;
        }
    }
}
@end
