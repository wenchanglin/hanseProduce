//
//  UIImage+Utils.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/26.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Utils)
@property(class, nonatomic, readonly) NSArray<UIImage*> *net_loading_imgs;
@property(class, nonatomic, readonly) UIImage *black_back;
@property(class, nonatomic, readonly) UIImage *white_back;
+(nullable UIImage*)linerThemeImageWithSize: (CGSize)sz;

@end

NS_ASSUME_NONNULL_END
