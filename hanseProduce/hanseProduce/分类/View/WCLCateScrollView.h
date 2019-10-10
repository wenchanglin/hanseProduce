//
//  WCLCateScrollView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/28.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselView.h"
#import "WCLGoodsDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^lookAllCommentsBlock)(NSInteger pid);
typedef void(^scrollViewOffsetBlock)(CGFloat cellOffy);

@interface WCLCateScrollView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,strong)CarouselView*cycleScrollView;
@property(nonatomic,strong)WCLGoodsDetailModel*mainModel;
@property(nonatomic,assign)ProductStyle goodsStyle;
@property(nonatomic,copy)lookAllCommentsBlock lookAllCommentsBlock;
@property(nonatomic,copy)scrollViewOffsetBlock scrollViewOffsetBlock;
@property(nonatomic,strong)UILabel*detailSecondLabel;
@property(nonatomic,strong)UILabel*commentLabel;
@end

NS_ASSUME_NONNULL_END
