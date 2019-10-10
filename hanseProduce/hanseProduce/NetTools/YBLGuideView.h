//
//  YBLGuideView.h
//  YC168
//
//  Created by wen on 2017/5/25.
//  Copyright © 2017年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GuideViewDoneBlock)(void);

@interface YBLGuideView : UIView

+ (void)showGuideViewWithDataArray:(NSMutableArray *)dataArray doneBlock:(GuideViewDoneBlock)doneBlock;

@end
