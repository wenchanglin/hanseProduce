//
//  WCLHomeSliderFourLevelCollectionView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/26.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeSliderFourLevelCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray*dataArr;
@end

NS_ASSUME_NONNULL_END
