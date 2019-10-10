//
//  ClassifyTwoPicsReusableView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/10/10.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^bannerClickItemBlock)(BOOL ispush,UIViewController*vc);
@interface ClassifyTwoPicsReusableView : UICollectionReusableView<CarouselDelegate>
@property(nonatomic, strong) CarouselView *carouseView;
@property(nonatomic,strong)NSMutableArray*picsArr;
@property(nonatomic,copy)bannerClickItemBlock bannerClickItemBlock;

@end

NS_ASSUME_NONNULL_END
