//
//  AppDelegate.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import "WeiBoApiManager.h"
#import "WCLAppViewModel.h"
#import <GTSDK/GeTuiSdk.h>

#import "TDAlertView.h"
#import "WeiboSDK.h"
#import "WCLTabBarViewController.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()<GeTuiSdkDelegate,UNUserNotificationCenterDelegate,TDAlertViewDelegate>
@property (nonatomic, assign) BOOL Noti;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    WCLAppViewModel*appViewModel = [WCLAppViewModel shareApp];
//    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    [self registerRemoteNotification];
    self.Noti=NO;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runMainViewController) name:@"showmoney" object:nil];
    [appViewModel finishLaunchOption:launchOptions];
    [appViewModel showLaunchAnimationView];
    return YES;
}
-(void)runMainViewController
{
    WCLTabBarViewController *tabBarVC = [[WCLTabBarViewController alloc] init];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
}
-(void)runWhiteVC{
    UIViewController * viewController = [[UIViewController alloc] init];
    UINavigationController*nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
}
- (void)registerRemoteNotification {
   
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
    //    MessageCount *message = [MessageCount getNotifationCount];
    //    message.notifationCount = 0;
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    // 向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    //    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    NSMutableDictionary * parmeter = [NSMutableDictionary dictionary];
    parmeter[@"clientId"] = clientId;
    [[wclNetTool sharedTools]request:POST urlString:URL_BindGeTui parameters:parmeter finished:^(id responseObject, NSError *error) {
        //        WCLLog(@"%@",responseObject);
    }];
    
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    
    if (_Noti) {
        _Noti = NO;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:payloadMsg forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GeTui" object:nil userInfo:dic];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"roadCound" object:nil];
    WCLLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    if (payloadMsg.length>0) {
        TDAlertItem*item = [[TDAlertItem alloc]initWithTitle:@"确定"];
        TDAlertView*alert= [[TDAlertView alloc]initWithTitle:@"推送消息" message:payloadMsg items:@[item] delegate:self];
        [alert show];
    }
}
-(void)alertView:(TDAlertView *)alertView didClickItemWithIndex:(NSInteger)itemIndex
{
    [alertView hide];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    if ([UIApplication sharedApplication].applicationState ==UIApplicationStateBackground ) {
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        _Noti = YES;
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId {
    
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            WCLLog(@"result = %@",resultDic);
            if ([[resultDic stringForKey:@"resultStatus"] integerValue] == 9000) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PayFlase" object:nil];
            }

        }];

//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            WCLLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            WCLLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
    }else if ([url.host isEqualToString:@"pay"]) {
        return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    else
    {
        return [WeiboSDK handleOpenURL:url delegate:[WeiBoApiManager sharedManager]];
        
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //            WCLLog(@"result = %@",resultDic);
            if ([[resultDic stringForKey:@"resultStatus"] integerValue] == 9000) {

                [[NSNotificationCenter defaultCenter] postNotificationName:@"PaySuccess" object:nil];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PayFlase" object:nil];
            }

        }];

//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            //            WCLLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            WCLLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
    }else if ([url.host isEqualToString:@"pay"]) {
        return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    else
    {
        return [WeiboSDK handleOpenURL:url delegate:[WeiBoApiManager sharedManager]];
        
    }
    return YES;
}


@end
