//
//  WCLAppViewModel.m
//  BaiDaYueCheng
//
//  Created by 文长林 on 2018/5/14.
//  Copyright © 2018年 文长林. All rights reserved.
//

#import "WCLAppViewModel.h"
#import "PageControlView.h"
#import "YBLUpdateVersionView.h"
#import "WCLMineViewController.h"
#import "AppDelegate.h"
#import "WCLPrivacyView.h"
#import "WCLPrivacyH5ViewController.h"
@interface WCLAppViewModel()
@property(strong , nonatomic)PageControlView *pageControlV;
@end
static WCLAppViewModel * appView=nil;

@implementation WCLAppViewModel

+(WCLAppViewModel *)shareApp
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appView = [[WCLAppViewModel alloc]init];
    });
    return appView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


-(void)finishLaunchOption:(NSDictionary *)option
{
    [self setUpSvpProgress];
//    [AvoidCrash becomeEffective];
    [IQKeyboardManager sharedManager].previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [IQKeyboardManager sharedManager].toolbarTintColor = YBLColor(40, 40, 40, 1);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:YBLColor(40, 40, 40, 1), NSFontAttributeName:YBLFont(18)}];
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attrs[NSForegroundColorAttributeName] = YBLColor(70, 70, 70, 1);
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [self NetWorking];
//    [self checkAppVersion];
    [self PanDuanFirstorOther];
    
}
-(void)PanDuanFirstorOther
{
    AppDelegate*appdelegate = ((AppDelegate*)[UIApplication sharedApplication].delegate);
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [appdelegate runWhiteVC];
        // 这里判断是否第一次
        WCLPrivacyView*privacyView = [[WCLPrivacyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:privacyView];
        [privacyView setAgreeBlock:^{
            [self showGuideView];
        }];
        [privacyView setPrivacyBlock:^(NSInteger index) {
            WCLPrivacyH5ViewController*h5 =[[WCLPrivacyH5ViewController alloc]init];
            h5.url = @"http://m.hfbh.com.cn/mall/html/staticPage/app_privacy_policy.html";
            UINavigationController*jhv = [[UINavigationController alloc]initWithRootViewController:h5];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:jhv animated:NO completion:nil];
        }];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [appdelegate runMainViewController];
        
    }

}
-(void)NetWorking
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                //                NSLog(@"未知网络");
                break;
            case 0:
                //                NSLog(@"网络不可达");
                break;
            case 1:
                //                NSLog(@"GPRS网络");
                break;
            case 2:
                //                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            //            NSLog(@"有网");
            [WCLUserManageCenter shareInstance].isNoActiveNetStatus = NO;
        }else
        {
            //            NSLog(@"没有网");
            [WCLUserManageCenter shareInstance].isNoActiveNetStatus = YES;
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ///监听网络
        WEAK
        [RACObserve([WCLUserManageCenter shareInstance], isNoActiveNetStatus) subscribeNext:^(NSNumber*  _Nullable x) {
            STRONG
            if (x.boolValue) {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                UINavigationController *navVc = [self getNavigationCWithWindow:window];
                if ([navVc isKindOfClass:[WCLMineViewController class]]) {//||[navVc isKindOfClass:[WCLFindViewController class]]
                    [YBLNetWorkHudBar startMonitorWithVc:navVc];
                }
                else
                {
                    [YBLNetWorkHudBar startMonitorWithVc:navVc.visibleViewController];
                }
            } else {
                [YBLNetWorkHudBar dismissHudView];
                if ([WCLUserManageCenter shareInstance].isLoginStatus) {
                    
                }
                else
                {
                    
                }
            }
            [SVProgressHUD dismiss];
            [YBLLogLoadingView dismissInWindow];
        }];
    });
}
- (UINavigationController *)getNavigationCWithWindow:(UIWindow *)window;{
    UITabBarController *tabVC = (UITabBarController  *)window.rootViewController;
    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    return pushClassStance;
}

//初始化提示框
- (void)setUpSvpProgress {
    
    [[UIButton appearance] setExclusiveTouch:YES];
//    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"hud_error"]];
//    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"hud_success"]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setCornerRadius:6];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"#474A4D" alpha:.97]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setFont:YBLFont(16)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    CGFloat wi = YBLWindowWidth/3-space;//250;
    [SVProgressHUD setMinimumSize:CGSizeMake(wi, wi)];
    
}
- (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}
- (void)checkAppVersion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString * URL = nil;
        if ([[self getPreferredLanguage] hasPrefix:@"zh-"]) {
            URL = @"https://itunes.apple.com/search?term=百大悦城&country=cn&entity=software";
            URL = [URL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        }
        else //en-US 英文版
        {
            URL = @"http://itunes.apple.com/lookup?id=1084967248";//1159191582 1084967248
        }
       
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        if (!data) {
            return ;
        }
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        jsonDict = [jsonDict[@"results"] firstObject];
        
        if (!error && jsonDict) {
            NSString *newVersion =jsonDict[@"version"];
            NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
            
            NSString *dot = @".";
            NSString *whiteSpace = @"";
            int newV = [newVersion stringByReplacingOccurrencesOfString:dot withString:whiteSpace].intValue;
            int nowV = [nowVersion stringByReplacingOccurrencesOfString:dot withString:whiteSpace].intValue;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(newV > nowV)
                {
        
                    //需要更新
                    YBLUpdateReaseNotModel *notModel = [YBLUpdateReaseNotModel new];
                    notModel.releaseNot = jsonDict[@"releaseNotes"];
                    notModel.version =jsonDict[@"version"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:App_Notification_Version object:nil userInfo:@{@"model":notModel}];
                }
                
            });
        }
    });
    
    
}

- (void)showLaunchAnimationView{
    
    BOOL noFirstLaunch = [[[NSUserDefaults standardUserDefaults] objectForKey:NO_FIRST_LAUNCH_KEY] boolValue];
    if (noFirstLaunch) {
        //正常动画
        [self showAnimationLaunchImageView];
    } else {
        //引导页
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:NO_FIRST_LAUNCH_KEY];
    }
}

- (void)showGuideView{
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i < 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"guide_image_%@",@(i)];//[ShiPeiIphoneXSRMax isIPhoneX]?[NSString stringWithFormat:@"img_guideview_%@X",@(i)]:
        [imageArray addObject:imageName];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _pageControlV = [[PageControlView instance] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImageList:imageArray];
    [window addSubview:self.pageControlV];
}



- (void)showAnimationLaunchImageView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    __block UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage getTheLaunchImage]];
    launchView.frame = window.bounds;
    launchView.contentMode = UIViewContentModeScaleAspectFill;
    launchView.userInteractionEnabled = NO;
    [window addSubview:launchView];
    
    UIImage *launchImage = [UIImage imageNamed:@"loadding_line"];
    UIImageView *launchbgImageView = [[UIImageView alloc] initWithImage:launchImage];
    launchbgImageView.frame = CGRectMake(0, 0, launchImage.size.width, launchImage.size.height);
    launchbgImageView.center = launchView.center;
    [launchView addSubview:launchbgImageView];
    
    UIImage *launchProgressArrowImage = [UIImage imageNamed:@"launchProgressIcon"];
    UIImageView *launchProgressArrowImageView = [[UIImageView alloc] initWithImage:launchProgressArrowImage];
    launchProgressArrowImageView.frame = CGRectMake(0, 0, launchProgressArrowImage.size.width, launchProgressArrowImage.size.height);
    launchProgressArrowImageView.center = CGPointMake(launchProgressArrowImage.size.width/2, launchbgImageView.height/2);
    [launchbgImageView addSubview:launchProgressArrowImageView];
    
    [UIView animateWithDuration:0.7f
                          delay:0.7f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         launchProgressArrowImageView.left = launchbgImageView.width-launchProgressArrowImageView.width*1.5;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0f
                                               delay:0.5f
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              launchView.alpha = 0.0f;
                                              launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1);
                                          }
                                          completion:^(BOOL finished) {
                                              [launchView removeFromSuperview];
                                              launchView = nil;
                                          }];
                     }];
    
}




@end
