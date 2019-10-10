//
//  CALayer+ShowUrl.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/20.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "CALayer+ShowUrl.h"
#import "YYWebImage.h"
@implementation CALayer (ShowUrl)
-(void)showImgUrl: (nullable NSString *)url placeholder: (nullable UIImage *)placeholderImage {
    if (!url) {
        if (placeholderImage) {
            self.contents =  (__bridge id _Nullable)([placeholderImage CGImage]);
        }
        return;
    }
    NSString *encodeUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (!encodeUrl) {
        encodeUrl = url;
    }
    NSURL *Url = [NSURL URLWithString:encodeUrl];
    [self yy_setImageWithURL:Url placeholder:placeholderImage];
}
@end
