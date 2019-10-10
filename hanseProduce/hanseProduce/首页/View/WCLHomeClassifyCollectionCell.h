//
//  WCLHomeClassifyCollectionCell.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/23.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHomeClassifyModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^MoreBtnClickBlock)(WCLHomeClassifyModel*models);
@interface WCLHomeClassifyCollectionCell : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray*btnArr;
@property(nonatomic,strong)UICollectionView*collectView;
@property(nonatomic,copy)MoreBtnClickBlock moreBtnClickBlock;
@end

NS_ASSUME_NONNULL_END
