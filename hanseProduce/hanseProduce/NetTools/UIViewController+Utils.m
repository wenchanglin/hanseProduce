//
//  UIViewController+Utils.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/27.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "BaseProject-Swift.h"
@implementation UIViewController (Utils)
-(BOOL)checkIsReallyLogin {
    switch ([AppConfigs shared].loginStatus) {
        case LoginStatusIn:
            return true;
            break;
        case LoginStatusOut:
        {
            CenterAlterController *vc = [[CenterAlterController alloc] initWithTitle:@"请先登录再操作" message:nil cancelButtonTitle:@"取消" cancelHandle:nil okButtonTitle:@"登录" okHandle:^{
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
                navi.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:navi animated:true completion:nil];
            }];
            [vc showFromSourceController:self];
        }
            return false;
            break;
        case LoginStatusVisitor:
        {
            BindMobileView *bv = [[BindMobileView alloc] init];
            [bv showInView:self.view];
        }
            return false;
            break;
        default:
            return true;
            break;
    }
}
@end
