//
//  WCLHotDataTwoLevelCell.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/24.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHotDataModel.h"
#import "BaseCollectionCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface WCLHotDataTwoLevelCell : BaseCollectionCell
@property(nonatomic,strong)UIImageView*backImageView;
@property(nonatomic,strong)UIImageView*picImageView;
@property(nonatomic,strong)UILabel*nowPriceLabel;
@property(nonatomic,strong)UILabel*oldPriceLabell;
@property(nonatomic,strong)UIImageView*couponImageView;
@property(nonatomic,strong)UILabel*couponPriceLabel;
@property(nonatomic,strong)UILabel*NoLabel;
@property(nonatomic,strong)UILabel* titlelabels;
@property(nonatomic,strong)WCLHotDataModel*model;

@end

NS_ASSUME_NONNULL_END
