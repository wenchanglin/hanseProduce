//
//  ProductListController.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ProductListController.h"
#import "ProductListViewModel.h"
#import "ProductListService.h"
@interface ProductListController ()
@property(nonatomic,strong)ProductListService*service;
@property(nonatomic,strong)ProductListViewModel*viewModel;
@end

@implementation ProductListController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.titles;
    self.viewModel = [[ProductListViewModel alloc]init];
    self.service=[[ProductListService alloc]initWithVC:self ViewModel:self.viewModel];
    
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
