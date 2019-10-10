//
//  WCLHomeHotDataCell.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/24.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeHotDataCell : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIImageView*backView;
@property(nonatomic,strong)UIImageView*titleImageView;
@property(nonatomic,strong)NSMutableArray*hotDataArr;
@property(nonatomic,strong)UICollectionView*collectView;

@end

NS_ASSUME_NONNULL_END
