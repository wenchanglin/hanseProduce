//
//  UIImageView+ShowUrl.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/17.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "UIImageView+ShowUrl.h"
#import <YYWebImage.h>
@implementation UIImageView (ShowUrl)
-(void)showImgUrl: (nullable NSString *)url placeholder: (nullable UIImage *)placeholderImage {
    if (!url) {
        self.image = placeholderImage;
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
