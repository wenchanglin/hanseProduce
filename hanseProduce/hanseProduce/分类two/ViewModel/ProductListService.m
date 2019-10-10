//
//  ProductListService.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ProductListService.h"
#import "ProductListController.h"
#import "ProductListViewModel.h"
#import "ClassifyTwoCollectionView.h"
#import "WCLHomeThemeCollectionCell.h"
#import "WCLHomeThemeModel.h"
#import "WCLGoodsDetailVC.h"
#import "ClassifyTwoPicsReusableView.h"
@interface ProductListService()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)ProductListViewModel*viewModel;
@property(nonatomic,strong)ProductListController*productListVC;
@property(nonatomic,strong)ClassifyTwoCollectionView*collectionView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)BOOL isPull;
@end
@implementation ProductListService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if (self==[super initWithVC:VC ViewModel:viewModel]) {
        _productListVC=(ProductListController*)VC;
        _viewModel=(ProductListViewModel*)viewModel;
        self.page=0;
        self.isPull=YES;
        [self createUI];
        [self requestData];
    }
    return self;
}
-(void)requestData
{
    WEAK
    switch (self.productListVC.style) {
        case  ProductListStyleGift:  // 礼包专区
        {
            STRONG
            self.productListVC.title=@"礼包专区";
            [[self.viewModel ProductDataListWithDownPull:self.isPull WithPage:self.page withCatetype:1]subscribeNext:^(id  _Nullable x) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer endRefreshing];
                [self.collectionView reloadData];
            }];
        }
            break;
        case  ProductListStyleBrand: //品牌专区
        {
            STRONG
            self.productListVC.title=@"品牌专区";
            [[self.viewModel ProductDataListWithDownPull:self.isPull WithPage:self.page withCatetype:3]subscribeNext:^(id  _Nullable x) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer endRefreshing];
                [self.collectionView reloadData];
            }];
        }break;
        case ProductListStyleNew:    //新人专享
        {
            STRONG
            self.productListVC.title=@"新人专享";
            [[self.viewModel ProductDataListWithDownPull:self.isPull WithPage:self.page withCatetype:4]subscribeNext:^(id  _Nullable x) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer endRefreshing];
                [self.collectionView reloadData];
            }];
            
        }break;
        case ProductListStyleClassify:
        {
            STRONG
            [[self.viewModel ProductDataWithDownPull:self.isPull WithPage:self.page withCateId:self.productListVC.cid sorttype:1 withCatetype:2]subscribeNext:^(id  _Nullable x) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer endRefreshing];
                [self.collectionView reloadData];
            }];
        }break;
        default:
            break;
    }
    
}

-(void)createUI
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.productListVC.view);
    }];
}
-(ClassifyTwoCollectionView *)collectionView
{
    WEAK
    if (!_collectionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.minimumLineSpacing = 0;
        fl.minimumInteritemSpacing = 0;
        _collectionView=[[ClassifyTwoCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:fl];
        _collectionView.backgroundColor = UIColor.canvas;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO; // 隐藏滚动条
        [_collectionView registerClass:[WCLHomeThemeCollectionCell class] forCellWithReuseIdentifier:@"productTwoCell"];
        [_collectionView registerClass:[ClassifyTwoPicsReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassifyTwoPicsReusableView"];
        [self.productListVC.view addSubview:_collectionView];
        [[BaseRefreshTool shareInterface]setupEmpty:_collectionView image: [UIImage imageNamed:@"place_googs"] title:@"暂无商品哦~"];
        [[BaseRefreshTool shareInterface] setupRefresh:_collectionView option:ATHeaderRefresh completion:^{
            STRONG
            self.page=0;
            self.isPull=YES;
            [self.viewModel.cell_data_dict removeAllObjects];
            [self requestData];
        }] ;
        [[BaseRefreshTool shareInterface] setupRefresh:_collectionView option:ATFooterRefresh completion:^{
            STRONG
            self.isPull=NO;
            self.page+=1;
            [self requestData];
        }];
        
    }
    return _collectionView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel.cell_data_dict[@"classifyArr"]count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WCLHomeThemeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"productTwoCell" forIndexPath:indexPath];
    WCLHomeThemeModel *c = self.viewModel.cell_data_dict[@"classifyArr"][indexPath.item];
    cell.model=c;
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([self.viewModel.cell_data_dict[@"banner"]count]>0) {
        ClassifyTwoPicsReusableView*view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassifyTwoPicsReusableView" forIndexPath:indexPath];
        view.picsArr=self.viewModel.cell_data_dict[@"banner"];
        [view setBannerClickItemBlock:^(BOOL ispush, UIViewController * _Nonnull vc) {
            if (ispush) {
                [self.productListVC pushToController:vc];
            }
            else
            {
                [self.productListVC swipePresentTo:vc];
            }
        }];
        return view;
    }
    return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(SCREEN_WIDTH/2, 282);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if ([self.viewModel.cell_data_dict[@"banner"]count]>0) {
        return CGSizeMake(collectionView.width, 170);
    }
    return CGSizeMake(collectionView.width, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WCLHomeThemeModel *c = self.viewModel.cell_data_dict[@"classifyArr"][indexPath.item];
    WCLGoodsDetailVC *vc = [[WCLGoodsDetailVC alloc] init];
    vc.goodsStyle=ProductStyleNormal;
    vc.p_id=c.p_id;
    vc.hidesBottomBarWhenPushed = true;
    [self.productListVC swipePresentTo:vc];
}
@end
