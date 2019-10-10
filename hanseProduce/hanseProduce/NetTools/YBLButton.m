//
//  YBLButton.m
//  YBL365
//
//  Created by wen on 12/20/16.
//  Copyright © 2016 wen. All rights reserved.
//

#import "YBLButton.h"

@implementation YBLButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [super imageRectForContentRect:contentRect];
}

- (void)setHighlighted:(BOOL)highlighted{
    
}


@end
