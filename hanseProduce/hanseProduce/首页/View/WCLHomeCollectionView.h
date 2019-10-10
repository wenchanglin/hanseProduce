//
//  WCLHomeCollectionView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLHomeBannerModel.h"
#import "WCLHomeThemeCollectionCell.h"
#import "WCLHomeClassifyModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol WCLHomeCollectionViewDelegate <NSObject>
@optional
-(void)cellOffsetyWithoffy:(CGFloat)celloffy;
-(void)homeBannerTapWithPush:(BOOL)ispush withVC:(UIViewController*)VC;
-(void)homeHotDataSelectMoreBtnWithModel:(WCLHomeBannerModel*)model;
-(void)homeThreePicTapWithPush:(BOOL)ispush withVC:(UIViewController*)VC;
-(void)homeMainThemeMoreData;
-(void)homeMainThemeSelectItemWithpid:(NSInteger)pid;
-(void)homeMoreBtnsClickWithModel:(WCLHomeClassifyModel*)model;
@end
@interface WCLHomeCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray*themeArr;
@property(nonatomic,strong)NSMutableArray*bannerArr;
@property(nonatomic,strong)NSMutableArray*classifyArr;
@property(nonatomic,strong)NSMutableArray*threePicArr;
@property(nonatomic,strong)NSMutableArray*gifPicArr;
@property(nonatomic,strong)NSMutableArray*hoth5Arr;
@property(nonatomic,strong)NSMutableArray*hotArr;
@property(nonatomic,strong)NSMutableArray*sliderTitleArr;
@property(nonatomic,strong)NSMutableArray*sliderMoreDataArr;
@property(nonatomic,strong)UIViewController*homeTwoVCs;
@property(nonatomic,weak)id<WCLHomeCollectionViewDelegate>delegates;
@end

NS_ASSUME_NONNULL_END
