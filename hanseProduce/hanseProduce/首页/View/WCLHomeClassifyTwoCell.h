//
//  WCLHomeClassifyTwoCell.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/23.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHomeClassifyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeClassifyTwoCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView*headImageView;
@property(nonatomic,strong)UILabel*headLabel;
@property(nonatomic,strong)WCLHomeClassifyModel*models;
@end

NS_ASSUME_NONNULL_END
