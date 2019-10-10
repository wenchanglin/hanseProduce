//
//  UIViewController+HUD.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/20.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <Toast.h>
@implementation UIViewController (HUD)

-(void)showIndicator {
    [self.view makeToastActivity:CSToastPositionCenter];
}

-(void)hideIndicator {
    [self.view hideToastActivity];
}

-(void)showMessage: (nonnull NSString *)message {
    [self.view makeToast:message duration:1.0 position:CSToastPositionCenter];
}

-(void)showMessage: (nonnull NSString *)message then: (nonnull void (^)(void))block {
//    __weak typeof(self) weakSelf = self;
    [self.view makeToast:message duration:1.0 position:CSToastPositionCenter title:NULL image:NULL style:NULL completion:^(BOOL didTap) {
        if (block) {
//            __strong __typeof(weakSelf)strongSelf = weakSelf;
            block();
        }
    }];
}

@end
