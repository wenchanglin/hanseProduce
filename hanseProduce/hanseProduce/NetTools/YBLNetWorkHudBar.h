//
//  YBLNetWorkHudBar.h
//  YC168
//
//  Created by wen on 2017/5/1.
//  Copyright © 2017年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBLNetWorkHudBar : UIView

+ (void)startMonitorWithVc:(UIViewController *)selfVc;

+ (void)dismissHudView;

+ (void)setHudViewHidden:(BOOL)isHidden;

@end
