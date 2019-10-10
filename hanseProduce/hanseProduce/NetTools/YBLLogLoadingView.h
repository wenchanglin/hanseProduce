//
//  YBLLogLoadingView.h
//  YC168
//
//  Created by wen on 2017/5/27.
//  Copyright © 2017年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBLLogLoadingView : UIView

-(void)show;

-(void)dismiss;

+(void)showInView:(UIView*)view;

+(void)dismissInView:(UIView*)view;

+ (void)showInWindow;

+ (void)dismissInWindow;

@end
