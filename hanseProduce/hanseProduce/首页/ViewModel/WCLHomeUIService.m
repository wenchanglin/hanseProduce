//
//  HomeView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeUIService.h"
#import "WCLHomeViewController.h"
#import "WCLHomeViewModel.h"
#import "WCLHomeCollectionView.h"
#import "YBLHomeNavigationView.h"
#import "WCLGoodsDetailVC.h"
#import "SecondClassifyController.h"
#import "ProductListController.h"
@interface WCLHomeUIService()<WCLHomeCollectionViewDelegate>
@property (nonatomic, weak) WCLHomeViewController *homeVC;
@property (nonatomic, assign) BOOL isAgree;
@property (nonatomic, weak) WCLHomeViewModel *viewModel;
@property (nonatomic, strong) YBLHomeNavigationView *navigationView;//自定义导航条

@property(nonatomic,assign)NSInteger page;
@end
@implementation WCLHomeUIService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _homeVC = (WCLHomeViewController*)VC;
        _page=0;
        _viewModel = (WCLHomeViewModel*)viewModel;
        [self createUI];
        [self requestHomeData];
    }
    return self;
}
-(void)createUI{
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([ShiPeiIphoneXSRMax isIPhoneX]?-44:-20);
        make.width.equalTo(self.homeVC.view);
        make.bottom.mas_equalTo(0);
    }];
    self.navigationView = [[YBLHomeNavigationView alloc] initWithFrame:CGRectMake(0,0, YBLWindowWidth, [ShiPeiIphoneXSRMax isIPhoneX]?88:kNavigationbarHeight) navigationType:NavigationTypeHome];
    [self.homeVC.view addSubview:self.navigationView];
}
- (void)requestHomeData{
    WEAK
    [[self.viewModel homeThreePicWithDownPull:YES WithPage:_page] subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.collectionView.threePicArr=self.viewModel.cell_data_dict[@"threepic"];
        self.collectionView.gifPicArr=self.viewModel.cell_data_dict[@"homegif"];
    }];
    [[self.viewModel HomeHotDataWithDownPull:YES WithPage:_page]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.collectionView.hoth5Arr=self.viewModel.cell_data_dict[@"homehoth5"];
        self.collectionView.hotArr=self.viewModel.cell_data_dict[@"homehotdata"];
    }];
    [[self.viewModel HomeDataWithDownPull:YES WithPage:_page]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.collectionView.themeArr=self.viewModel.cell_data_dict[@"hometheme"];
        self.collectionView.bannerArr=self.viewModel.cell_data_dict[@"homebanner"];
    }];
    [[self.viewModel HomeClassifyWithDownPull:YES WithPage:_page]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.collectionView.classifyArr=self.viewModel.cell_data_dict[@"homeclassify"];
    }];
    [[self.viewModel HomeSliderTitleWithDownPull:YES WithCid:1]subscribeNext:^(id  _Nullable x) {
        STRONG
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if ([self.viewModel.cell_data_dict[@"homeslidertitle"]count]>0) {
            [[NSUserDefaults standardUserDefaults]setObject:self.viewModel.cell_data_dict[@"homeslidertitle"] forKey:@"slidertitle"];
            [[NSUserDefaults standardUserDefaults]setObject:self.viewModel.cell_data_dict[@"homecateid"] forKey:@"cateid"];
        }
    }];
}
-(WCLHomeCollectionView *)collectionView{
    WEAK
    if (!_collectionView) {
        UICollectionViewFlowLayout*flow=[[UICollectionViewFlowLayout alloc]init];
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow.minimumLineSpacing = 0;
        _collectionView =[[WCLHomeCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.delegates=self;
        _collectionView.homeTwoVCs=self.homeVC;
        [self.homeVC.view addSubview:_collectionView];
        [[BaseRefreshTool shareInterface]setupEmpty:_collectionView];
        [[BaseRefreshTool shareInterface] setupRefresh:_collectionView option:ATHeaderRefresh completion:^{
            STRONG
            self.page=0;
            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestHomeData];
        }] ;
        [[BaseRefreshTool shareInterface] setupRefresh:_collectionView option:ATFooterRefresh completion:^{
            STRONG
            self.page+=1;
            [self requestHomeData];
        }];
    }
    return _collectionView;
}
#pragma mark - WCLHomeCollectionViewDelegate
-(void)homeBannerTapWithPush:(BOOL)ispush withVC:(UIViewController *)VC
{
    if (ispush) {
        [self.homeVC pushToController:VC];
    }
    else
    {
        [self.homeVC swipePresentTo:VC];
    }
}
-(void)homeMoreBtnsClickWithModel:(WCLHomeClassifyModel *)model
{
    if (model.type == 1) { // 礼包
        ProductListController*prv = [[ProductListController alloc]init];
        prv.style=ProductListStyleGift;
        prv.cid=0;
        [self.homeVC pushToController:prv];
        return;
    }
    if (model.type == 2) { // 签到
        WCLLog(@"签到");
//        if ([self checkIsReallyLogin]) {
//            [self customCenterAlterViewController:[[QiandaoController alloc] init]];
//        }
        return;
    }
    if (model.type == 3 && model.url && model.url.length > 0) { // 咨询中心
        if (model.url && model.url.length > 0) {
            NSURL *url = [NSURL URLWithString:model.url];
            WCLLog(@"h5");
//            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[WebController alloc] initWithUrl:url]];
//            [self swipePreentTo:navi];
        } else {
            [self.homeVC showMessage:@"敬请期待"];
        }
        return;
    }
    SecondClassifyController*scfy=[[SecondClassifyController alloc] init];
    scfy.cate_id=model.cate_id;
    scfy.title=model.cate_title;
    [self.homeVC pushToController:scfy];
}
-(void)homeThreePicTapWithPush:(BOOL)ispush withVC:(UIViewController *)VC
{
    if (ispush) {
        [self.homeVC pushToController:VC];
    }
    else
    {
        [self.homeVC swipePresentTo:VC];
    }
    
}

-(void)homeHotDataSelectMoreBtnWithModel:(WCLHomeBannerModel *)model
{
    WCLLog(@"%@",model);
}
-(void)homeMainThemeMoreData
{
     self.homeVC.tabBarController.selectedIndex = 1;
}
-(void)homeMainThemeSelectItemWithpid:(NSInteger)pid
{
    WCLGoodsDetailVC*dvc = [[WCLGoodsDetailVC alloc]init];
    dvc.goodsStyle=ProductStyleNormal;
    dvc.p_id=pid;
    [self.homeVC swipePresentTo:dvc];
}
-(void)cellOffsetyWithoffy:(CGFloat)celloffy
{
    if (celloffy > NAVBAR_CHANGE_POINT) {
        if(self.isOver) return ;
        self.isOver = true;
        [self.navigationView changeColorWithState:YES];
        self.navigationView.backgroundColor = YBLColor(255, 255, 255, 1);
    }else {
        CGFloat alpa = celloffy/NAVBAR_CHANGE_POINT;
        if (alpa > 0.8) {
            self.navigationView.backgroundColor = YBLColor(255, 255, 255, 1);
            return ;
        }
        [self.navigationView changeColorWithState:NO];
        self.isOver = false;
        self.navigationView.backgroundColor = YBLColor(255, 255, 255, alpa);
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
