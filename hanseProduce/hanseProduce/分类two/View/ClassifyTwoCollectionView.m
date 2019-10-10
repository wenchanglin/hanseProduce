//
//  ClassifyTwoCollectionView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/9.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ClassifyTwoCollectionView.h"

@implementation ClassifyTwoCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self==[super initWithFrame:frame collectionViewLayout:layout]) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
