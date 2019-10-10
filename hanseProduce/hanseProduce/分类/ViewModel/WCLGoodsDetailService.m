//
//  WCLGoodsDetailService.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/27.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLGoodsDetailService.h"
#import "WCLGoodsDetailVC.h"
#import "WCLGoodsDetailViewModel.h"
#import "WCLCateNavigationView.h"
#import "WCLCateScrollView.h"
#import "WCLGoodsDetailModel.h"
#import "JXButton.h"
#import "SizeChooseView.h"
#import "YBImageBrowser.h"
#import "YBIBVideoData.h"
@interface WCLGoodsDetailService()<CarouselDelegate>
@property(nonatomic,strong)WCLGoodsDetailViewModel*viewModel;
@property(nonatomic,strong) UIButton *item1,*item2,*item3, *addCar,*addOrder,*onlyOrderButton;
@property(nonatomic,strong)WCLGoodsDetailModel*mainModel;
@property(nonatomic,strong)NSMutableArray*bannerArr;
@property(nonatomic,strong)WCLGoodsDetailVC*goodsVC;
@property(nonatomic,strong)UIView *bottomToolView;
@property(nonatomic,assign) BOOL isOver;
@property (nonatomic, strong) SizeChooseView *sizeView;

@property (nonatomic, strong) WCLCateNavigationView *navigationView;//自定义导航条
@property(nonatomic,assign) CGFloat goodTopContentOffset,commentTopContentOffset,detailTopContentOffset;
@end
@implementation WCLGoodsDetailService
-(instancetype)initWithVC:(UIViewController *)VC ViewModel:(NSObject *)viewModel
{
    if(self==[super initWithVC:VC ViewModel:viewModel])
    {
        _bannerArr=[NSMutableArray array];
        _goodsVC=(WCLGoodsDetailVC*)VC;
        _viewModel = (WCLGoodsDetailViewModel*)viewModel;
        _goodTopContentOffset = [ShiPeiIphoneXSRMax isIPhoneX]?88:64;
        [self _createUI];
        [self reloadData];
    }
    return self;
}
-(void)reloadData{
    WEAK
    [[self.viewModel CateDetailDataWithDownPull:YES Withpid:self.goodsVC.p_id]subscribeNext:^(id  _Nullable x) {
        STRONG
        if([x isKindOfClass:[NSString class]])
        {
            [self.goodsVC showMessage:@"商品不存在!" then:^{
                [self.goodsVC dismissViewControllerAnimated:YES completion:NULL];
            }];
        }
        else
        {
            self.bannerArr = self.viewModel.cell_data_dict[@"banner"];
            self.mainModel =self.viewModel.cell_data_dict[@"mainModel"];
            self.mainScrollView.mainModel =self.mainModel;
            [self.mainScrollView.cycleScrollView reload];
        }
        if (self.mainModel.p_stock==0) {
            [self.addCar setEnabled:NO];
            [self.addOrder setEnabled:NO];
            [self.onlyOrderButton setEnabled:NO];
            [self.onlyOrderButton setHidden:NO];
        }
        else
        {
            [self.addCar setEnabled:YES];
            [self.addOrder setEnabled:YES];
            [self.onlyOrderButton setEnabled:YES];
            [self.onlyOrderButton setHidden:YES];
            //显示购物车 和 下单 按钮  报单-余额-特殊 只显示下单
            if (self.mainModel.p_type== 1 || self.mainModel.p_type== 2 || self.mainModel.p_type == 4) {
                [self.onlyOrderButton setHidden:NO];
            }else{
                //品牌
                [self.onlyOrderButton setHidden:YES];
            }
        }
        
        
    }];
}
- (void)_createUI{
    [self.goodsVC.view addSubview:self.mainScrollView];
    [self leftback];
    [self bottomView];
}
-(void)leftback{
    self.navigationView = [[WCLCateNavigationView alloc] initWithFrame:CGRectMake(0,0, YBLWindowWidth, [ShiPeiIphoneXSRMax isIPhoneX]?88:kNavigationbarHeight) navigationType:NavigationTypeHome];
    WEAK
    [[self.navigationView.backButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        if (self.goodsVC.ispush) {
            [self.goodsVC.navigationController popViewControllerAnimated:YES];
        }
        [self.goodsVC dismissViewControllerAnimated:YES completion:nil];
    }];
    [[self.navigationView.shangpinButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSArray *offsetArray = @[@(self.goodTopContentOffset),@(self.commentTopContentOffset),@(self.detailTopContentOffset)];
        NSInteger index = x.tag-10;
        //+1是为了弥补CGFloat引起的小数误差
        CGFloat offset = [offsetArray[index] floatValue]+1;
        [UIView animateWithDuration:0.3 animations:^{
            //            self.mainScrollView.contentOffset = CGPointMake(0, offset);
            WCLLog(@"%f",offset);
        }];
    }];
    
    [self.goodsVC.view addSubview:self.navigationView];
}
-(void)bottomView{
    _bottomToolView = [[UIView alloc] initWithFrame:CGRectMake(0, [ShiPeiIphoneXSRMax isIPhoneX]?SCREEN_HEIGHT-50-34:SCREEN_HEIGHT-50-0, SCREEN_WIDTH, [ShiPeiIphoneXSRMax isIPhoneX]?84:50)];
    _bottomToolView.backgroundColor = [UIColor whiteColor];
    [self.goodsVC.view addSubview:_bottomToolView];
    NSArray *nameArr1 = @[@"客服"];
    NSArray *imageArr1 = @[@"detail_service"];
    CGFloat x = (_bottomToolView.width - 16 - 200) * 0.5 - 40;
    JXButton *button = [[JXButton alloc] initWithFrame:CGRectMake(x,[ShiPeiIphoneXSRMax isIPhoneX]?15:0, 80, 40)];
    [button setImage:[UIImage imageNamed:imageArr1[0]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = kRegularFont(11);
    [button setTitle:nameArr1[0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAc:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomToolView addSubview:button];
    NSArray *nameArr2 = @[@"加入购物车",@"立即购买",@"立即购买"];
    _addCar = [UIButton new];
    _addOrder = [UIButton new];
    _onlyOrderButton = [UIButton new];
    [_onlyOrderButton setHidden:YES];
    NSArray *btnArrr = @[_addCar,_addOrder,_onlyOrderButton];
    //立即购买和加入购物车
    for (int i = 0; i <nameArr2.count; i++) {
        UIButton *btn = (UIButton *)btnArrr[i];
        if (i < 2) {
            CGFloat x = _bottomToolView.width - 16 - 100 *(2 - i);
            btn.frame = CGRectMake(x, 7, 100, 36);
        } else {
            btn.frame = CGRectMake(_bottomToolView.width - 16 - 200, 7, 200, 36);
        }
        btn.centerY=button.centerY;
        btn.tag = 1000+i;
        btn.titleLabel.font = kRegularFont(14);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor py_colorWithHexString:@"999999"] forState:UIControlStateDisabled];
        [btn setTitle:nameArr2[i] forState:UIControlStateNormal];
        [btn setTitle:nameArr2[i] forState:UIControlStateHighlighted];
        if (i > 0) {
            [btn setTitle:@"已售馨" forState:UIControlStateDisabled];
        }
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor py_colorWithHexString:@"eeeeee"]] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(buttonActon:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomToolView addSubview:btn];
        if (i == 2) {
            [_bottomToolView bringSubviewToFront:btn];
        }
        CAShapeLayer *shap = [[CAShapeLayer alloc] init];
        shap.frame = btn.bounds;
        if (i==0) {
            UIColor *leftC= [UIColor colorWithHexString:@"#FF5160"];
            UIColor*rightC=[UIColor colorWithHexString:@"#F3293A"];
            UIImage *img111 = [UIImage gradientColorImageFromColors:@[leftC,rightC] gradientType:GradientTypeLeftToRight imgSize:btn.size];
            [btn setBackgroundImage:img111 forState:UIControlStateNormal];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(18, 18)];
            shap.path = path.CGPath;
        }else if(i==1){
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor theme]] forState:UIControlStateNormal];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(18, 18)];
            shap.path = path.CGPath;
        } else {
            [btn setBackgroundImage:[UIImage linerThemeImageWithSize:btn.size] forState:UIControlStateNormal];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(18, 18)];
            shap.path = path.CGPath;
        }
        btn.layer.mask = shap;
    }
}
- (void)buttonActon:(UIButton *)sender{
//    if (!_goodDetailModel) {
//        return;
//    }
//    if (![self check]) {
//        return;
//    }
    if (_mainModel.is_size  == 0) {
        if ([sender.currentTitle isEqualToString:@"加入购物车"]) {
            //直接加入购物车
//            [self addCarWithDic:@{@"user_id":U_ID?:@"",@"token":U_TOKEN?:@"",
//                                  @"p_id":self.p_id?:@"",@"size_id":@"0",@"number":@"1"}];
            
        }else{
            //直接到确认下单页面
//            NSDictionary *dic = @{@"p_id":self.p_id?:@"",@"size_id":@"0",@"od_num":@"1",@"size_title":@"",@"size_cash":_goodDetailModel.p_cash?:@"0",@"size_balance":_goodDetailModel.p_balance?:@""};
//            [self pushCheckOrderWithDic:dic];
        }
        
    }else{
        [self chooseTheGoodsSize];
        if ([sender.currentTitle isEqualToString:@"加入购物车"]) {
            //购物车
            _sizeView.type = 1;
        }else{
            //立即购买
            _sizeView.type = 2;
        }
    }
    
}
- (void)chooseTheGoodsSize{
    if (!_mainModel) {
        return;
    }
    [self.sizeView show];
    self.sizeView.p_cash = self.mainModel.p_cash;
    self.sizeView.p_balance = self.mainModel.p_balance;
    
    self.sizeView.p_type = [NSNumber numberWithInteger:self.mainModel.p_type];
    self.sizeView.p_pic = self.mainModel.p_list_pic;
    self.sizeView.p_id = [NSString stringWithFormat:@"%@",@(self.mainModel.p_id)];
    
    
    __weak typeof(self) weakSelf = self;
    self.sizeView.finishChooseBlock = ^(NSString *size, NSInteger number, ChooseSizeType type, NSString *s_id, NSString *price, NSString *stock, NSString *size_cash, NSString *size_balance) {
        //加入购物车
        if (type == ChooseSizeTypeToShopcar) {
            
//            [weakSelf addCarWithDic:@{@"user_id":U_ID?:@"",@"token":U_TOKEN?:@"",
//                                      @"p_id":weakSelf.p_id,@"size_id":s_id,@"number":@(number)
//                                      }];
        }else{
            //下单
//            NSDictionary *dic = @{@"p_id":weakSelf.p_id,@"size_id":s_id,@"od_num":@(number),@"size_title":size,@"size_cash":size_cash,@"size_balance":size_balance};
//            [weakSelf pushCheckOrderWithDic:dic];
        }
        
    };
}

- (void)buttonAc:(UIButton *)sender{
    WCLLog(@"你点击了客服");
    //    if (![self check]) {
    //        return;
    //    }
    //    NSDictionary<NSString*, NSString*> *dic = @{@"user_id": [AppConfigs shared].user_id, @"token": [AppConfigs shared].user_token, @"type": @"1"};
    //    DZWeakSelf(self);
    //    [[Request shared] postPath:@"/api/user/getCustomService" requestParameters:dic success:^(id  _Nonnull value) {
    //        NSString *kid = [NSString stringWithFormat:@"%@", value];
    //        if (!kid) {
    //            return;
    //        }
    //        PersonChatViewController *vc = [[PersonChatViewController alloc] init];
    //        vc.isPresent = true;
    //        vc.targetId = kid;
    //        vc.conversationType = ConversationType_PRIVATE;
    //        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    //        navi.modalPresentationStyle = UIModalPresentationFullScreen;
    //        [weakself presentViewController:navi animated:true completion:nil];
    //    } failure:^(NSError * _Nonnull error) {
    //    }];
}
- (SizeChooseView *)sizeView{
    if (!_sizeView) {
        _sizeView = [[SizeChooseView alloc] init];
    }
    return _sizeView;
}
- (WCLCateScrollView *)mainScrollView{
    if (!_mainScrollView) {
        WEAK
        self.goodsVC.automaticallyAdjustsScrollViewInsets=NO;
        _mainScrollView = [[WCLCateScrollView alloc] initWithFrame:CGRectMake(0, [ShiPeiIphoneXSRMax isIPhoneX]?-44:-20, SCREEN_WIDTH, [ShiPeiIphoneXSRMax isIPhoneX]?SCREEN_HEIGHT-34:SCREEN_HEIGHT-24)];
        _mainScrollView.cycleScrollView.delegate=self;
        _mainScrollView.goodsStyle=self.goodsVC.goodsStyle;
        _mainScrollView.detailSecondLabel.didFinishAutoLayoutBlock = ^(CGRect frame) {
            STRONG
            self.detailTopContentOffset = self.mainScrollView.detailSecondLabel.top -self.goodTopContentOffset;
//            WCLLog(@"%f",self.detailTopContentOffset);
        };
        [_mainScrollView.commentLabel setDidFinishAutoLayoutBlock:^(CGRect frame) {
            STRONG
            self.commentTopContentOffset = self.mainScrollView.commentLabel.top -self.goodTopContentOffset;
//            WCLLog(@"%f",self.commentTopContentOffset);
        }];
        [_mainScrollView setLookAllCommentsBlock:^(NSInteger pid) {
            WCLLog(@"%d",pid);
            /*  CommentListViewController *list = [[CommentListViewController alloc] init];
             list.p_id = _mainModel.p_id;
             [self.navigationController pushViewController:list animated:YES];*/
        }];
        [_mainScrollView setScrollViewOffsetBlock:^(CGFloat cellOffy) {
            STRONG
            if (cellOffy > NAVBAR_CHANGE_POINT) {
                if(self.isOver) return ;
                self.isOver = true;
                [self.navigationView changeColorWithState:YES];
                self.navigationView.backgroundColor = YBLColor(255, 255, 255, 1);

            }else {

                CGFloat alpa = cellOffy/NAVBAR_CHANGE_POINT;
                if (alpa > 0.8) {
                    self.navigationView.backgroundColor = YBLColor(255, 255, 255, 1);
                    return ;
                }
                [self.navigationView changeColorWithState:NO];
                self.isOver = false;
                self.navigationView.backgroundColor = YBLColor(255, 255, 255, alpa);
            }
        }];
    }
    return _mainScrollView;
}

#pragma mark - CarouselDelegate
-(NSArray<NSString *> *)dataSourceForCarouselView:(CarouselView *)carouselView {
    
    NSMutableArray *carr = [NSMutableArray array];
    [self.bannerArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [carr addObject: obj[@"url"]];
    }];
    return carr;
}

-(NSArray<NSNumber *> *)dataSourceIsMovieForCarouselView:(CarouselView *)carouselView {
    
    NSMutableArray *carr = [NSMutableArray array];
    [self.bannerArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *isMovie = obj[@"isMovie"];
        if ([isMovie isEqualToString:@"1"]) {
            [carr addObject:[NSNumber numberWithBool:true]];
        } else {
            [carr addObject:[NSNumber numberWithBool:false]];
        }
    }];
    return carr;
}
-(void)didClickImageAtCarouselView:(CarouselView *)carouselView atIndex:(NSInteger)idx
{
    [carouselView stopPlay];
       NSMutableArray *datas = [NSMutableArray array];
       [self.bannerArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           NSString *isMovie = obj[@"isMovie"];
           NSString *url = obj[@"url"];
           if ([isMovie isEqualToString:@"1"]) {
               YBIBVideoData *data = [YBIBVideoData new];
               data.videoURL = [NSURL URLWithString:url];
               data.projectiveView = carouselView;
               [datas addObject:data];
           } else {
               YBIBImageData *data = [YBIBImageData new];
               data.imageURL = [NSURL URLWithString:url];
               data.projectiveView = carouselView;
               [datas addObject:data];
           }
       }];
       YBImageBrowser *browser = [YBImageBrowser new];
       browser.dataSourceArray = datas;
       browser.currentPage = idx;
       [browser show];
}
@end
