//
//  WCLTabBarViewController.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLTabBarViewController.h"
#import "WCLHomeViewController.h"
#import "WCLMineViewController.h"
#import "SlideTypesController.h"
#import "ShoppCarViewController.h"
#import "ClassifyTwoController.h"
@interface WCLTabBarViewController ()

@end

@implementation WCLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createSubVc];
}
#pragma mark - 系统tabbar
- (void)createSubVc{
    self.tabBar.tintColor = [UIColor colorWithHexString:@"#e70014"];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:kSpecialFont(11)} forState:UIControlStateNormal];
    
    WCLHomeViewController*homeVC = [[WCLHomeViewController alloc] init];
    SlideTypesController* stvc = [[SlideTypesController alloc] init];
    ClassifyTwoController*class2 = [[ClassifyTwoController alloc]init];
    ShoppCarViewController*shop = [[ShoppCarViewController alloc] init];
    WCLMineViewController* my = [[WCLMineViewController alloc] init];
    [self addChildVc:homeVC withImage:@"home" withSelectedImage:@"tab_home_hig" withTitle:@"首页"];
    [self addChildVc:stvc withImage:@"tab_classify_nor" withSelectedImage:@"tab_classify_high" withTitle:@"分类"];
    [self addChildVc:class2 withImage:@"tab_classify_nor" withSelectedImage:@"tab_classify_high" withTitle:@"分类2"];
    [self addChildVc:shop withImage:@"shopcar" withSelectedImage:@"tab_shop_hig" withTitle:@"购物车"];
    my.title = @"我的";
    my.tabBarItem.image = [[UIImage imageNamed:@"person"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    my.tabBarItem.selectedImage = [[UIImage imageNamed:@"person_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:my];
}
- (void)addChildVc:(UIViewController *)viewController withImage:(NSString *)imageStr withSelectedImage:(NSString *)selectedImageStr withTitle:(NSString *)title{
    UINavigationController *baseNav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [baseNav.navigationBar setShadowImage:[UIImage new]];
    viewController.tabBarItem.image = [[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.title = title;
    [self addChildViewController:baseNav];
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
