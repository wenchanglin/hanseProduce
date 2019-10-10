//
//  WCLHomeThreeLevelCollectionVC.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/25.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeThreeLevelCollectionVC.h"
#import "WCLHomeSliderFourLevelCollectionView.h"
#import "WCLHomeViewModel.h"
@interface WCLHomeThreeLevelCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)WCLHomeViewModel*viewModel;
@end

@implementation WCLHomeThreeLevelCollectionVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self requestData];
    [self addRacObserver];
}
-(void)addRacObserver
{
    [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"homescroll" object:nil] map:^id(NSNotification *value) {
        return value.userInfo;
    }] distinctUntilChanged] subscribeNext:^(id x) {
        self.cate_id= [[x stringForKey:@"cateid"]integerValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestData2];
        });
    }];
}
-(void)requestData2
{
    WEAK
    if (self.cate_id==self.view.tag) {
        self.viewModel=[[WCLHomeViewModel alloc]init];
        [[self.viewModel HomeSliderDataWithDownPull:YES WithCid:self.cate_id]subscribeNext:^(id  _Nullable x) {
            STRONG
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            self.collectionView.dataArr=self.viewModel.cell_data_dict[@"homeslider"];
        }];
    }
}
-(void)requestData
{
    WEAK
        self.viewModel=[[WCLHomeViewModel alloc]init];
        [[self.viewModel HomeSliderDataWithDownPull:YES WithCid:self.cate_id]subscribeNext:^(id  _Nullable x) {
            STRONG
            WCLLog(@"x:%@",x);
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            self.collectionView.dataArr=self.viewModel.cell_data_dict[@"homeslider"];
        }];
    
}
-(void)createUI{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(500);
    }];
}
-(WCLHomeSliderFourLevelCollectionView *)collectionView
{
    WEAK
    if (!_collectionView) {
        UICollectionViewFlowLayout*flow=[[UICollectionViewFlowLayout alloc]init];
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow.minimumLineSpacing = 0;
        _collectionView = [[WCLHomeSliderFourLevelCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        [self.view addSubview:_collectionView];
        [[BaseRefreshTool shareInterface]setupEmpty:_collectionView];
//        [[BaseRefreshTool shareInterface] setupRefresh:_collectionView option:ATHeaderRefresh completion:^{
//            STRONG
////            self.page=1;
//            [self.viewModel.cell_data_dict removeAllObjects];
//            [self requestData2];
//        }] ;
        [[BaseRefreshTool shareInterface] setupRefresh:_collectionView option:ATFooterRefresh completion:^{
            STRONG
//            self.page+=1;
            [self requestData2];
        }];
    }
    return _collectionView;
}



@end
