//
//  UIButton+DZButton.m
//  BaseProject
//
//  Created by Sunsgne on 2018/8/30.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import "UIButton+DZButton.h"

static const char dz_bind_id;

@implementation UIButton (DZButton)
@dynamic bind_id;


- (void)setBind_id:(NSString *)bind_id{
    objc_setAssociatedObject(self, &dz_bind_id, bind_id, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)bind_id{
    return objc_getAssociatedObject(self, &dz_bind_id);
}


@end
