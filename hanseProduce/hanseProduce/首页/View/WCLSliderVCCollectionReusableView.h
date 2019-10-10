//
//  WCLSliderVCCollectionReusableView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/25.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXPageTabView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WCLSliderVCCollectionReusableView : UICollectionReusableView
//XXPageTabViewDelegate
//@property (nonatomic, strong) XXPageTabView *pageTabView;
//@property(nonatomic,strong)UIViewController*VC;
//@property (strong, nonatomic) NSMutableArray *dataArr;
//@property(nonatomic,strong)NSMutableArray*titleArr;
@property(nonatomic,strong)UILabel*titleLabels;
@property(nonatomic,strong)UIButton*moreBtn;
@end

NS_ASSUME_NONNULL_END
