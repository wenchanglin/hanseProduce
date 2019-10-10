//
//  ShareCustom.m
//  CategaryShow
//
//  Created by 黄梦炜 on 2016/12/11.
//  Copyright © 2016年 Mr.huang. All rights reserved.
//

#import "ShareCustom.h"
#import <QuartzCore/QuartzCore.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import "WeiboSDK.h"
//设备物理大小
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion floatValue]
//屏幕宽度相对iPhone6屏幕宽度的比例
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
@implementation ShareCustom

static id _publishContent;//类方法中的全局变量这样用（类型前面加static）
static id _controller;
/*
 自定义的分享类，使用的是类方法，其他地方只要 构造分享内容publishContent就行了
 */

+(void)shareWithContent:(id)publishContent/*只需要在分享按钮事件中 构建好分享内容publishContent传过来就好了*/
{
    
    
    _publishContent = publishContent;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIButton *blackView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    blackView.tag = 440;
    [window addSubview:blackView];
    [blackView addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(15, [ShiPeiIphoneXSRMax isIPhoneX]?kScreenHeight -185:kScreenHeight-175, kScreenWidth-30, 160)];
    shareView.layer.cornerRadius=8;
    shareView.layer.masksToBounds=YES;
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.tag = 441;
    [window addSubview:shareView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, (kScreenWidth-30), 40)];
    titleLabel.text = @"分享到";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [shareView addSubview:titleLabel];
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40-35,10,35,35)];
    cancleBtn.centerY = titleLabel.centerY;
    [cancleBtn setImage:[UIImage imageNamed:@"address_close"] forState:UIControlStateNormal];
    cancleBtn.tag = 339;
//    cancleBtn.backgroundColor = [UIColor cyanColor];
    [cancleBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:cancleBtn];
    
    NSArray *btnImages = @[@"wx",@"pyq",@"qq"];
    NSArray *btnTitles = @[@"微信",@"微博",@"QQ"];
    for (NSInteger i=0; i<3; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-30) / 3 * i, 50, (kScreenWidth-30) / 3, 80)];
        [button setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        button.tag = 331+i;
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:button];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-30) / 3 * i, 115, (kScreenWidth-30) / 3, 30)];
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setText:btnTitles[i]];
        [label setTextColor:[UIColor blackColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [shareView addSubview:label];
        
    }
    
    
    //    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 1)];
    //    [lineView setBackgroundColor:[UIColor lightGrayColor]];
    //    [shareView addSubview:lineView];
    //
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
    blackView.alpha = 0;
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1, 1);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}



+(void)shareContent:(id)publishContent controller:(UIViewController *)control/*只需要在分享按钮事件中 构建好分享内容publishContent传过来就好了*/
{
    
    _controller = control;
    _publishContent = publishContent;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIButton *blackView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    blackView.tag = 440;
    [window addSubview:blackView];
    [blackView addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, [ShiPeiIphoneXSRMax isIPhoneX]?kScreenHeight -185:kScreenHeight-175, kScreenWidth, 160)];
    
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.tag = 441;
    [window addSubview:shareView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, shareView.width-100, 40)];
    titleLabel.text = @"分享到";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [shareView addSubview:titleLabel];
    
    NSArray *btnImages = @[@"wx",@"pyq",@"qq"];
    NSArray *btnTitles = @[@"微信",@"微博",@"QQ"];
    for (NSInteger i=0; i<3; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 3 * i, 40, kScreenWidth / 3, 80)];
        [button setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        button.tag = 331+i;
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:button];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 3 * i, 110, kScreenWidth / 3, 30)];
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setText:btnTitles[i]];
        [label setTextColor:[UIColor blackColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [shareView addSubview:label];
        
    }
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 1)];
    [lineView setBackgroundColor:[UIColor lightGrayColor]];
    [shareView addSubview:lineView];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,155,kScreenWidth,40)];
    [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleBtn.tag = 339;
    [cancleBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:cancleBtn];
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
    blackView.alpha = 0;
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1, 1);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}



+(void)shareBtnClick:(UIButton *)btn
{
    //    NSLog(@"%@",[ShareSDK version]);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
        blackView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
    }];
    
    if (_controller) {
        [_controller dismissViewControllerAnimated:YES completion:nil];
    }
    
    int shareType = 0;
    id publishContent = _publishContent;
    switch (btn.tag) {
        case 331:
        {
            shareType = SSDKPlatformSubTypeWechatSession;
        }
            break;
            
        case 332:
        {
            //SSDKPlatformSubTypeWechatTimeline;
            if ([WeiboSDK isWeiboAppInstalled]) {
                shareType = SSDKPlatformTypeSinaWeibo;
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"未安装微博App，无法通过微博分享"];
            }
        }
            break;
            
        case 333:
        {
            shareType = SSDKPlatformSubTypeQQFriend;
        }
            break;
            
            
            
        default:
            break;
    }
    
    /*
     调用shareSDK的无UI分享类型，
     链接地址：http://bbs.mob.com/forum.php?mod=viewthread&tid=110&extra=page%3D1%26filter%3Dtypeid%26typeid%3D34
     */
    
    
    
    [ShareSDK share:shareType parameters:publishContent onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        if (state == SSDKResponseStateSuccess)
        {
            //            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
            
            
            
        }
        else if (state == SSDKResponseStateFail)
        {
            WCLLog( @"分享失败,错误描述:%@",error);
        }
        
    }];
    
    
    //    [ShareSDK showShareViewWithType:shareType container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id statusInfo, id error, BOOL end) {
    //        if (state == SSDKResponseStateSuccess)
    //        {
    //            //            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
    //        }
    //        else if (state == SSDKResponseStateFail)
    //        {
    //            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"未检测到客户端 分享失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //            [alert show];
    //            //            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
    //        }
    //    }];
    
    
    
}
@end
