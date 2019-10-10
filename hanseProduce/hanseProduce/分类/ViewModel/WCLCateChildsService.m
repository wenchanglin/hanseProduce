//
//  WCLCateChildsService.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/27.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLCateChildsService.h"
#import "WCLCateChildsViewController.h"
#import "WCLHomeViewModel.h"
#import "WCLCateCollectionView.h"
#import "WCLGoodsDetailVC.h"
@interface WCLCateChildsService()
@property(nonatomic,strong)WCLHomeViewModel*viewModel;
@property(nonatomic,strong)WCLCateChildsViewController*cateVC;
@property(nonatomic,strong)WCLCateCollectionView*collectionView;
@property(nonatomic,assign)NSInteger page;
@end
@implementation WCLCateChildsService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _cateVC=(WCLCateChildsViewController*)VC;
        _viewModel=(WCLHomeViewModel*)viewModel;
        self.page=0;
        [self addRacObserver];
        [self requestData:YES];
        [self createUI];
    }
    return self;
}
-(void)addRacObserver
{
    [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"cateScroll" object:nil] map:^id(NSNotification *value) {
        return value.userInfo;
    }] distinctUntilChanged] subscribeNext:^(id x) {
        self.cateVC.cate_id= [[x stringForKey:@"cateid"]integerValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestData2:YES];
        });
    }];
}
-(void)createUI{
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.equalTo(self.cateVC.view);
        make.bottom.mas_equalTo(0);
    }];
}
-(void)requestData2:(BOOL)ispull
{
    WEAK
    if (self.cateVC.cate_id==self.cateVC.view.tag) {
        [[self.viewModel HomeSliderDataWithDownPull:ispull WithCid:self.cateVC.cate_id withPage:self.page]subscribeNext:^(id  _Nullable x) {
            STRONG
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            self.collectionView.cateDataArr=self.viewModel.cell_data_dict[@"homeslider"];
        }];
    }
}
-(void)requestData:(BOOL)ispull
{
    WEAK
    [[self.viewModel HomeSliderDataWithDownPull:ispull WithCid:self.cateVC.cate_id withPage:self.page]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.collectionView.cateDataArr=self.viewModel.cell_data_dict[@"homeslider"];
    }];
    
}
-(WCLCateCollectionView *)collectionView{
    WEAK
    if (!_collectionView) {
        UICollectionViewFlowLayout*flow=[[UICollectionViewFlowLayout alloc]init];
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow.minimumLineSpacing = 0;
        _collectionView =[[WCLCateCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
        [self.cateVC.view addSubview:_collectionView];
        [self.collectionView setCateSelectItemBlock:^(WCLHomeThemeModel * _Nonnull models) {
            STRONG
            WCLGoodsDetailVC*vc = [[WCLGoodsDetailVC alloc]init];
            vc.goodsStyle=ProductStyleNormal;
            vc.p_id = models.p_id;
            [self.cateVC swipePresentTo:vc];
        }];
        [[BaseRefreshTool shareInterface]setupEmpty:_collectionView];
        [[BaseRefreshTool shareInterface] setupRefresh:_collectionView option:ATHeaderRefresh completion:^{
            STRONG
            self.page=0;
            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestData:YES];
        }] ;
        [[BaseRefreshTool shareInterface] setupRefresh:_collectionView option:ATFooterRefresh completion:^{
            STRONG
            self.page+=1;
            [self requestData:NO];
        }];
    }
    return _collectionView;
}
@end
