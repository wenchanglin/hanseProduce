//
//  ViewController.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F6F6F6"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem *backItem;
    if (self.navigationController.viewControllers.count > 1) {
        backItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage black_back] style:UIBarButtonItemStyleDone target:self action:@selector(goback1)];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}
- (void)goback1{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)swipePresentTo: (UIViewController *)vc {
    [self customSwipePresentViewController:vc withGesture:nil];
    [self resetSwipeDelegate];
}
-(void)pushToController: (UIViewController *)vc {
    [vc setHidesBottomBarWhenPushed:true];
    [self.navigationController pushViewController:vc animated:true];
}
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES ;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
