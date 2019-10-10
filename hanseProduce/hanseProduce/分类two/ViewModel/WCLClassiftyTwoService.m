//
//  WCLClassiftyTwoService.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLClassiftyTwoService.h"
#import "WCLClassifyTwoViewModel.h"
#import "ClassifyTwoController.h"
#import "ClassifyOneCell.h"
#import "ProductClassify.h"
#import "CarouselView.h"
#import "WCLHomeBannerModel.h"
#import "ClassifyTwoCell.h"
#import "UIViewController+SwipeTransition.h"
#import "ProductListController.h"
#import "ClassifyTwoCollectionView.h"
#import "YBLHomeNavigationView.h"
@interface WCLClassiftyTwoService()<UICollectionViewDelegate,UICollectionViewDataSource,CarouselDelegate>
@property(nonatomic,strong)WCLClassifyTwoViewModel*viewModel;
@property(nonatomic,strong)ClassifyTwoController*classify2VC;
@property(nonatomic, strong) ClassifyTwoCollectionView *leftView;
@property(nonatomic, strong) ClassifyTwoCollectionView *rightView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic, strong) CarouselView *carouseView;
@property (nonatomic, strong) YBLHomeNavigationView *navigationView;//自定义导航条

@end
@implementation WCLClassiftyTwoService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        self.classify2VC.view.backgroundColor=[UIColor whiteColor];
        _classify2VC=(ClassifyTwoController*)VC;
        _viewModel=(WCLClassifyTwoViewModel*)viewModel;
        self.page=0;
        self.viewModel.selectedIndex=0;
        [self createUI];
        [self requestData];
        //        [self requestData2];
        
    }
    return self;
}
-(void)createUI
{
    
    [self.classify2VC.view addSubview:self.navigationView];
    [self.classify2VC.view addSubview:self.leftView];
    [self.classify2VC.view addSubview:self.carouseView];
    [self.classify2VC.view addSubview:self.rightView];
    
}

-(void)requestData2
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ProductClassify*model1= self.viewModel.cell_data_dict[@"classify1"][self.viewModel.selectedIndex];
        [[self.viewModel classifyTwoWithDownPull:YES WithPage:0 withcateid:model1.cate_id]subscribeNext:^(id  _Nullable x) {
            [self.rightView reloadData];
            [self.carouseView reload];
        }];
    });
}
-(void)requestData
{
    [[self.viewModel classifyOneWithDownPull:YES WithPage:self.page]subscribeNext:^(id  _Nullable x) {
        ProductClassify*model1= self.viewModel.cell_data_dict[@"classify1"][self.viewModel.selectedIndex];
        [[self.viewModel classifyTwoWithDownPull:YES WithPage:0 withcateid:model1.cate_id]subscribeNext:^(id  _Nullable x) {
            [self.leftView reloadData];
            [self.rightView reloadData];
            [self.carouseView reload];
        }];
    }];
    
}
-(YBLHomeNavigationView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [[YBLHomeNavigationView alloc] initWithFrame:CGRectMake(0,0, YBLWindowWidth, [ShiPeiIphoneXSRMax isIPhoneX]?88:kNavigationbarHeight) navigationType:NavigationTypeCatgory];
        [[_navigationView.searchButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            //                        SearchController *vc = [[SearchController alloc] init];
            //                    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
            //                    navi.modalPresentationStyle = UIModalPresentationFullScreen;
            //                    [self presentViewController:navi animated:true completion:NULL];
        }];
    }
    return _navigationView;
}
- (ClassifyTwoCollectionView *)leftView{
    if (!_leftView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.minimumLineSpacing = 0;
        fl.minimumInteritemSpacing = 0;
        _leftView = [[ClassifyTwoCollectionView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom+10, 120,[ShiPeiIphoneXSRMax isIPhoneX]?SCREEN_HEIGHT-88:SCREEN_HEIGHT-64) collectionViewLayout:fl];
        _leftView.backgroundColor = [UIColor whiteColor];
        _leftView.showsVerticalScrollIndicator = false;
        _leftView.dataSource = self;
        _leftView.delegate = self;
        _leftView.showsVerticalScrollIndicator = NO; // 隐藏滚动条
        [_leftView registerClass:[ClassifyOneCell class] forCellWithReuseIdentifier:@"ClassifyOneCell"];
    }
    return _leftView;
}
- (ClassifyTwoCollectionView *)rightView{
    if (!_rightView) {
        
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.minimumLineSpacing = 0;
        fl.minimumInteritemSpacing = 0;
        fl.sectionInset = UIEdgeInsetsMake(0, YBLWidth_Scale*12, 0, YBLWidth_Scale*12);
        _rightView = [[ClassifyTwoCollectionView alloc] initWithFrame:CGRectMake(130, self.carouseView.bottom+10, SCREEN_WIDTH-120-20,SCREEN_HEIGHT-140) collectionViewLayout:fl];
        _rightView.backgroundColor = [UIColor whiteColor];
        _rightView.showsVerticalScrollIndicator = false;
        _rightView.dataSource = self;
        _rightView.delegate = self;
        _rightView.showsVerticalScrollIndicator = NO; // 隐藏滚动条
        [_rightView registerClass:[ClassifyTwoCell class] forCellWithReuseIdentifier:@"ClassifyTwoCell"];
    }
    return _rightView;
}
-(CarouselView *)carouseView
{
    if (!_carouseView) {
        _carouseView = [[CarouselView alloc]initWithFrame:CGRectMake(130,self.navigationView.bottom+10, SCREEN_WIDTH-120-20, 120)];
        _carouseView.delegate=self;
    }
    return _carouseView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.leftView) {
        return [self.viewModel.cell_data_dict[@"classify1"]count];
    }
    return  [self.viewModel.cell_data_dict[@"classify2"] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.leftView) {
        ClassifyOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassifyOneCell" forIndexPath:indexPath];
        ProductClassify *c = self.viewModel.cell_data_dict[@"classify1"][indexPath.item];
        cell.title = c.cate_title;
        [cell setSelected:self.viewModel.selectedIndex==indexPath.item];
        return cell;
    }
    ClassifyTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassifyTwoCell" forIndexPath:indexPath];
    ProductClassify *c = self.viewModel.cell_data_dict[@"classify2"][indexPath.item];
    [cell setTitle:c.cate_title imageUrl:c.img];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.leftView) {
        return  CGSizeMake(collectionView.width, 48);
    }
    CGFloat w = (collectionView.width - 36) * 0.333;
    return CGSizeMake(w, w + 15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (collectionView == self.leftView) {
        return  CGSizeZero;
    }
    return CGSizeMake(collectionView.width, 40);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.leftView) {
        self.viewModel.selectedIndex = indexPath.item;
        [self requestData2];
        [collectionView reloadData];
        return;
    }
    ProductClassify *c = self.viewModel.cell_data_dict[@"classify2"][indexPath.item];
    ProductListController *vc = [[ProductListController alloc] init];
    vc.style=ProductListStyleClassify;
    vc.titles=c.cate_title;
    vc.cid=c.cate_id;
    vc.hidesBottomBarWhenPushed = true;
    [self.classify2VC.navigationController pushViewController:vc animated:true];
}
#pragma mark - CarouselDelegate
-(NSArray<NSString *> *)dataSourceForCarouselView:(CarouselView *)carouselView {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [self.viewModel.cell_data_dict[@"pic"] enumerateObjectsUsingBlock:^(WCLHomeBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isVideo) {
            [arr addObject:obj.video];
        } else {
            [arr addObject:obj.img];
        }
    }];
    return arr;
}

-(NSArray<NSNumber *> *)dataSourceIsMovieForCarouselView:(CarouselView *)carouselView {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [self.viewModel.cell_data_dict[@"pic"] enumerateObjectsUsingBlock:^(WCLHomeBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:[NSNumber numberWithBool:obj.isVideo]];
    }];
    return arr;
}

-(void)didClickImageAtCarouselView:(CarouselView *)carouselView atIndex:(NSInteger)idx {
    WCLHomeBannerModel *c = self.viewModel.cell_data_dict[@"pic"][idx];
    if (c.isVideo) {
        return;
    }
    [WCLHomeBannerModel getControllerForStyle:c.style itemid:c.itemid withBlock:^(UIViewController * _Nonnull vc, BOOL isPush) {
        if (isPush) {
            [self.classify2VC.navigationController pushViewController:vc animated:YES];
        } else {
            [self.classify2VC swipePresentTo:vc];
        }
    }];
}

@end
