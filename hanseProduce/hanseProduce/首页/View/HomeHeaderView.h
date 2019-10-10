//
//  HomeHeaderView1.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/27.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderView : UIView
/// 轮播图高度
@property(class, assign, readonly) CGFloat carouselViewHeight;
/// 背景距离底部距离
@property(class, assign, readonly) CGFloat bglayerBottom;
/// 背景距离轮播痛顶部距离
@property(class, assign, readonly) CGFloat bglayerOffsetCarouseTop;

@property(nonatomic, strong, nullable) NSString *carouseColor;
@property(nonatomic, strong) CarouselView *carouslView;
@end

NS_ASSUME_NONNULL_END

