//
//  UIColor+HexString.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/8/24.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)

+(UIColor *)theme {
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#E70014"];
        }];
    }
    else

    {
        return [UIColor py_colorWithHexString:@"#E70014"];
    }
}

+(UIColor *)f0 {

    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#000000"];
        }];
    } else
    {
        return [UIColor py_colorWithHexString:@"#000000"];
    }
}

+(UIColor *)f3 {

    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#333333"];
        }];
    } else
    {

        return [UIColor py_colorWithHexString:@"#333333"];
    }
}

+(UIColor *)f6 {
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#666666"];
        }];
    } else
    {
        return [UIColor py_colorWithHexString:@"#666666"];
    }
}

+(UIColor *)f9 {

    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#999999"];
        }];
    } else
{
        return [UIColor py_colorWithHexString:@"#999999"];
    }
}

+(UIColor *)e1 {

    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#E1E1E1"];
        }];
    } else
    {
        return [UIColor py_colorWithHexString:@"#E1E1E1"];
    }
}

+(UIColor *)e {

    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#EEEEEE"];
        }];
    } else
    {
        return [UIColor py_colorWithHexString:@"#EEEEEE"];

    }
}

+(UIColor *)canvas {

    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#F6F6F6"];
        }];
    } else
    {
        return [UIColor py_colorWithHexString:@"#F6F6F6"];
    }
}

+(UIColor *)customGray {

    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor py_colorWithHexString:@"#f0f0f0"];
        }];
    } else
    {
        return [UIColor py_colorWithHexString:@"#f0f0f0"];

    }
}

+ (instancetype)py_colorWithHexString:(NSString *)hexString
{
    if (!hexString) {
        return [UIColor clearColor];
    }
    NSString *colorString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if (colorString.length < 6) {
        return [UIColor clearColor];
    }
    
    if ([colorString hasPrefix:@"0X"]) {
        colorString = [colorString substringFromIndex:2];
    }
    
    if ([colorString hasPrefix:@"#"]) {
        colorString = [colorString substringFromIndex:1];
    }
    
    if (colorString.length != 6) {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    // r
    NSString *rString = [colorString substringWithRange:range];
    
    // g
    range.location = 2;
    NSString *gString = [colorString substringWithRange:range];
    
    // b
    range.location = 4;
    NSString *bString = [colorString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0];
}

+ (instancetype)py_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    return [[self py_colorWithHexString:hexString] colorWithAlphaComponent:alpha];
}

@end
