//
//  UIImageView+ShowUrl.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/17.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ShowUrl)

/**
 显示网络图片
 
 @param url 图片url
 @param placeholderImage 占位图像
 */
-(void)showImgUrl: (nullable NSString *)url placeholder: (nullable UIImage *)placeholderImage;
@end

NS_ASSUME_NONNULL_END
