//
//  WCLHomeThreePicCell.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/24.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ThreeImageCellBlock)(NSInteger index);
@interface WCLHomeThreePicCell : UICollectionViewCell
@property( nonatomic,strong)NSMutableArray*threeArr;
@property(nonatomic,strong)UIImageView*firstImageView;
@property(nonatomic,strong)UIImageView*secondImageView;
@property(nonatomic,strong)UIImageView*threeImageView;
@property(nonatomic, copy) ThreeImageCellBlock ThreeImageTapBlock;


@end

NS_ASSUME_NONNULL_END
