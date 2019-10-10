//
//  WCLGoodsDetailVC.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/27.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLGoodsDetailVC.h"
#import "WCLGoodsDetailViewModel.h"
#import "WCLGoodsDetailService.h"
@interface WCLGoodsDetailVC ()
@property(nonatomic,strong)WCLGoodsDetailService*service;
@property(nonatomic,strong)WCLGoodsDetailViewModel*viewModel;
@end

@implementation WCLGoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel=[[WCLGoodsDetailViewModel alloc]init];
    self.service = [[WCLGoodsDetailService alloc]initWithVC:self ViewModel:self.viewModel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
