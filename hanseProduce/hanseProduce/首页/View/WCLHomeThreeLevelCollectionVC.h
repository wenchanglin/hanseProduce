//
//  WCLHomeThreeLevelCollectionVC.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/25.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class WCLHomeSliderFourLevelCollectionView;
NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeThreeLevelCollectionVC : ViewController
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)WCLHomeSliderFourLevelCollectionView*collectionView;
@property(nonatomic,assign)NSInteger cate_id;
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, assign) BOOL isRefresh;

@end

NS_ASSUME_NONNULL_END
