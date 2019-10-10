//
//  WCLHomeBannerReusableView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/23.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^bannerClickItemBlock)(BOOL ispush,UIViewController*vc);
@interface WCLHomeBannerReusableView : UICollectionReusableView<CarouselDelegate>
@property(nonatomic,strong)HomeHeaderView*headerView;
@property(nonatomic,copy)bannerClickItemBlock bannerClickItemBlock;
@property(nonatomic,strong)NSMutableArray*bannerArr;

@end

NS_ASSUME_NONNULL_END
