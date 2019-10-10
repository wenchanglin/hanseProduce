//
//  UIImage+Utils.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/26.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "UIImage+Utils.h"
#import "UIImage+XN.h"
@implementation UIImage (Utils)

+(NSArray<UIImage *> *)net_loading_imgs {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 32; i++) {
        NSString *str;
        if (i < 10) {
            str = [NSString stringWithFormat:@"net_loading_0%ld", (long)i];
        } else {
            str = [NSString stringWithFormat:@"net_loading_%ld", (long)i];
        }
        UIImage *i = [UIImage imageNamed:str];
        [arr addObject:i];
    }
    return arr;
}

+(UIImage *)white_back {
    return [UIImage imageNamed:@"white_back"];
}

+(UIImage *)black_back {
    return [[UIImage imageNamed:@"black_back" ]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(nullable UIImage*)linerThemeImageWithSize: (CGSize)sz {
    NSArray *arr = [NSArray arrayWithObjects:[UIColor colorWithHexString:@"#FF5160"],[UIColor colorWithHexString:@"#E70014"], nil];
    return [UIImage gradientColorImageFromColors:arr gradientType:GradientTypeLeftToRight imgSize:sz];
}

@end

