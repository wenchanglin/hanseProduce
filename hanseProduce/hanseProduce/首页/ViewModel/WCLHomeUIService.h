//
//  HomeView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLBaseService.h"
NS_ASSUME_NONNULL_BEGIN
@class WCLHomeCollectionView;
@interface WCLHomeUIService : WCLBaseService
@property(nonatomic,strong)WCLHomeCollectionView*collectionView;
@property (nonatomic, assign) CGFloat contentY;
@property(nonatomic,assign) BOOL isOver;

@end

NS_ASSUME_NONNULL_END
