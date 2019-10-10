//
//  UIColor+HexString.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/8/24.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexString)

@property(class, nonatomic, readonly) UIColor *theme;
@property(class, nonatomic, readonly) UIColor *f0;
@property(class, nonatomic, readonly) UIColor *f3;
@property(class, nonatomic, readonly) UIColor *f6;
@property(class, nonatomic, readonly) UIColor *f9;
@property(class, nonatomic, readonly) UIColor *e1;
@property(class, nonatomic, readonly) UIColor *e;
@property(class, nonatomic, readonly) UIColor *canvas;
@property(class, nonatomic, readonly) UIColor *customGray;

/**
 Returns the corresponding color according to the hexadecimal string.
 
 @param hexString   hexadecimal string(eg:@"#ccff88")
 @return new instance of `UIColor` class
 */
+ (instancetype)py_colorWithHexString:(NSString *)hexString;

/**
 Returns the corresponding color according to the hexadecimal string and alpha.
 
 @param hexString   hexadecimal string(eg:@"#ccff88")
 @param alpha       alpha
 @return new instance of `UIColor` class
 */
+ (instancetype)py_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
