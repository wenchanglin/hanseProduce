//
//  WCLCateChildsViewController.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/27.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLCateChildsViewController.h"
#import "WCLHomeViewModel.h"
#import "WCLCateChildsService.h"
@interface WCLCateChildsViewController ()
@property(nonatomic,strong)WCLHomeViewModel*viewModel;
@property(nonatomic,strong)WCLCateChildsService*service;
@end

@implementation WCLCateChildsViewController
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
    self.viewModel=[[WCLHomeViewModel alloc]init];
    self.service=[[WCLCateChildsService alloc]initWithVC:self ViewModel:self.viewModel];
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
