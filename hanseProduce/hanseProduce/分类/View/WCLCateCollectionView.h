//
//  WCLCateCollectionView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/27.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHomeThemeModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^cateSelectItemBlock)(WCLHomeThemeModel*models);
@interface WCLCateCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray*cateDataArr;
@property(nonatomic,copy)cateSelectItemBlock cateSelectItemBlock;
@end

NS_ASSUME_NONNULL_END
