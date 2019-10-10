//
//  ClassifyTwoController.m
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ClassifyTwoController.h"
#import "WCLClassifyTwoViewModel.h"
#import "WCLClassiftyTwoService.h"
@interface ClassifyTwoController ()
@property(nonatomic,strong)WCLClassifyTwoViewModel*viewModel;
@property(nonatomic,strong)WCLClassiftyTwoService*service;

@end

@implementation ClassifyTwoController
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
    [self bindUI];

}
-(void)bindUI{
    self.viewModel=[[WCLClassifyTwoViewModel alloc]init];
    self.service = [[WCLClassiftyTwoService alloc]initWithVC:self ViewModel:self.viewModel];
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
