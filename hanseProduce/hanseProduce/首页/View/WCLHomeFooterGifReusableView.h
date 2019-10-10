//
//  WCLHomeFooterGifReusableView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/24.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAnimatedImageView.h"
#import "UIImageView+YYWebImage.h"
#import "WCLHomeThreePicModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeFooterGifReusableView : UICollectionReusableView
@property(nonatomic,strong)YYAnimatedImageView*gifImageView;
@property(nonatomic,strong)WCLHomeThreePicModel*model;
@end

NS_ASSUME_NONNULL_END
