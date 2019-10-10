//
//  WCLHomeCollectionView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeCollectionView.h"
#import "WCLHomeThemeModel.h"
#import "WCLHomeClassifyModel.h"
#import "WCLHomeClassifyCollectionCell.h"
#import "WCLHomeBannerReusableView.h"
#import "WCLHomeFooterGifReusableView.h"
#import "WCLHomeThreePicCell.h"
#import "WCLHomeHotDataCell.h"
#import "WCLHomeHotReusableView.h"
#import "WCLSliderVCCollectionReusableView.h"
@interface WCLHomeCollectionView()
@end
@implementation WCLHomeCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self==[super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor=VIEW_BASE_COLOR;
        self.dataSource=self;
        self.delegate=self;
        [self registerClass:[WCLHomeThemeCollectionCell class] forCellWithReuseIdentifier:@"WCLHomeThemeCollectionCell"];
        [self registerClass:[WCLHomeClassifyCollectionCell class] forCellWithReuseIdentifier:@"WCLHomeClassifyCollectionCell"];
        [self registerClass:[WCLHomeThreePicCell class] forCellWithReuseIdentifier:@"WCLHomeThreePicCell"];
        [self registerClass:[WCLHomeHotDataCell class] forCellWithReuseIdentifier:@"WCLHomeHotDataCell"];
        [self registerClass:[WCLHomeBannerReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WCLHomeBannerReusableView"];
        [self registerClass:[WCLHomeHotReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WCLHomeHotReusableView"];
        [self registerClass:[WCLSliderVCCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WCLSliderVCCollectionReusableView"];
        [self registerClass:[WCLHomeFooterGifReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        
    }
    return self;
}

-(void)setThemeArr:(NSMutableArray *)themeArr{
    _themeArr=themeArr;
    [self reloadData];
}
-(void)setHoth5Arr:(NSMutableArray *)hoth5Arr
{
    _hoth5Arr=hoth5Arr;
    [self reloadData];
}
-(void)setHotArr:(NSMutableArray *)hotArr
{
    _hotArr=hotArr;
    [self reloadData];
}
//-(void)setSliderTitleArr:(NSMutableArray *)sliderTitleArr
//{
//    _sliderTitleArr=sliderTitleArr;
//    [self reloadData];
//}
//-(void)setSliderMoreDataArr:(NSMutableArray *)sliderMoreDataArr
//{
//    _sliderMoreDataArr=sliderMoreDataArr;
//    WCLLog(@"%@",_sliderMoreDataArr);
//    [self reloadData];
//}
-(void)setClassifyArr:(NSMutableArray *)classifyArr
{
    _classifyArr=classifyArr;
    [self reloadData];
}
-(void)setBannerArr:(NSMutableArray *)bannerArr
{
    _bannerArr=bannerArr;
    [self reloadData];
}
-(void)setThreePicArr:(NSMutableArray *)threePicArr
{
    _threePicArr=threePicArr;
    [self reloadData];
}
-(void)setGifPicArr:(NSMutableArray *)gifPicArr
{
    _gifPicArr=gifPicArr;
    [self reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if (section==2)
    {
        return 1;
    }
    else if (section==3)
    {
        return _themeArr.count;
        
    }
    else if(section==1)
    {
        return 1;
    }
    else
        return 0;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK
    if(indexPath.section==0)
    {
        WCLHomeClassifyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLHomeClassifyCollectionCell" forIndexPath:indexPath];
        cell.btnArr =_classifyArr;
        [cell setMoreBtnClickBlock:^(WCLHomeClassifyModel * _Nonnull models) {
            STRONG
            if ([self.delegates respondsToSelector:@selector(homeMoreBtnsClickWithModel:)]) {
                    [self.delegates homeMoreBtnsClickWithModel:models];
            }
        }];
        return cell;
    }
    else if(indexPath.section==1)
    {
        WCLHomeThreePicCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLHomeThreePicCell" forIndexPath:indexPath];
        cell.threeArr=_threePicArr;
        [cell setThreeImageTapBlock:^(NSInteger index) {
            STRONG
            WCLHomeThreePicModel*model1 = self.threePicArr[index];
            [WCLHomeThreePicModel getControllerForStyle:model1.style itemid:[NSString stringWithFormat:@"%ld",(long)model1.itemId] withBlock:^(UIViewController * _Nonnull vc, BOOL isPush) {
                if ([self.delegates respondsToSelector:@selector(homeThreePicTapWithPush:withVC:)]) {
                    [self.delegates homeThreePicTapWithPush:isPush withVC:vc];
                }
            }];
        }];
        return cell;
    }
    else if (indexPath.section==2)
    {
        WCLHomeBannerModel*model=_hoth5Arr[0];
        WCLHomeHotDataCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLHomeHotDataCell" forIndexPath:indexPath];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
        cell.hotDataArr=_hotArr;
        return cell;
    }
    else if (indexPath.section==3)
    {
        WCLHomeThemeModel *deModel = _themeArr[indexPath.item];
        WCLHomeThemeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLHomeThemeCollectionCell" forIndexPath:indexPath];
        cell.model=deModel;
        return cell;
        
    }
    return [UICollectionViewCell new];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WEAK
    if (indexPath.section==0) {
        if (kind==UICollectionElementKindSectionHeader) {
            WCLHomeBannerReusableView*view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WCLHomeBannerReusableView" forIndexPath:indexPath];
            view.bannerArr=_bannerArr;
            [view setBannerClickItemBlock:^(BOOL ispush, UIViewController * _Nonnull vc) {
                if ([self.delegates respondsToSelector:@selector(homeBannerTapWithPush:withVC:)]) {
                    [self.delegates homeBannerTapWithPush:ispush withVC:vc];
                }
                
            }];
            return view;
        }
        else
        {
            WCLHomeThreePicModel*model2 =_gifPicArr[0];
            WCLHomeFooterGifReusableView*view2 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
            view2.model=model2;
            return view2;
        }
    }
    else if (indexPath.section==2)
    {
        if (kind==UICollectionElementKindSectionHeader) {
            WCLHomeBannerModel*model=_hoth5Arr[0];
            WCLHomeHotReusableView*view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WCLHomeHotReusableView" forIndexPath:indexPath];
            [[[view.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:view.rac_prepareForReuseSignal]  subscribeNext:^(__kindof UIControl * _Nullable x) {
                STRONG
                if ([self.delegates respondsToSelector:@selector(homeHotDataSelectMoreBtnWithModel:)]) {
                    [self.delegates homeHotDataSelectMoreBtnWithModel:model];
                }
            }];
            return view;
        }
    }
    else if (indexPath.section==3)
    {
        if (kind==UICollectionElementKindSectionHeader) {
            WCLSliderVCCollectionReusableView*view3 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WCLSliderVCCollectionReusableView" forIndexPath:indexPath];
            [[[view3.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:view3.rac_prepareForReuseSignal]subscribeNext:^(__kindof UIControl * _Nullable x) {
                STRONG
                if ([self.delegates respondsToSelector:@selector(homeMainThemeMoreData)]) {
                    [self.delegates homeMainThemeMoreData];
                }
            }];
            return view3;
        }
    }
    return nil;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(SCREEN_WIDTH,YBLWidth_Scale*168);
    }
    else if(indexPath.section==1)
    {
        return CGSizeMake(SCREEN_WIDTH, YBLWidth_Scale*208);
    }
    else if(indexPath.section==2)
    {
        return CGSizeMake(SCREEN_WIDTH , YBLWidth_Scale*440);//316
    }
    else if(indexPath.section==3)
    {
        return CGSizeMake(SCREEN_WIDTH/2, 282);
    }
    else
        return CGSizeZero;
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(CGSize)collectionView: (UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection: (NSInteger)section{
    
    if (section==0) {
        CGSize size={[UIScreen mainScreen].bounds.size.width, (SCREEN_WIDTH/375*230)};
        return size;
    }
    else if (section==2)
    {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
    else if (section==3)
    {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
    return CGSizeZero;
    
}
-(CGSize)collectionView: (UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==0) {
        if (_gifPicArr.count>0) {
            CGSize size={YBLWidth_Scale*([UIScreen mainScreen].bounds.size.width-24), (SCREEN_WIDTH/375*110)};
            return size;
        }
        return CGSizeZero;
    }
    
    return CGSizeZero;
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==3)
    {
        WCLHomeThemeModel *deModel = _themeArr[indexPath.item];
        if ([self.delegates respondsToSelector:@selector(homeMainThemeSelectItemWithpid:)]) {
            [self.delegates homeMainThemeSelectItemWithpid:deModel.p_id];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat cellOffy = scrollView.contentOffset.y;
    if ([self.delegates respondsToSelector:@selector(cellOffsetyWithoffy:)]) {
        [self.delegates cellOffsetyWithoffy:cellOffy];
    }
    
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
