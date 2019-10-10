//
//  HomeController.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeViewController.h"
#import "WCLHomeViewModel.h"
#import "WCLHomeUIService.h"
@interface WCLHomeViewController ()
@property(nonatomic,strong)WCLHomeViewModel*viewModel;
@property(nonatomic,strong)WCLHomeUIService*homeUIService;
@end

@implementation WCLHomeViewController
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
    self.homeUIService = [[WCLHomeUIService alloc] initWithVC:self ViewModel:self.viewModel];


    
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
