//
//  WCLDataMacro.h
//  ceshiRac
//
//  Created by 文长林 on 2018/5/8.
//  Copyright © 2018年 文长林. All rights reserved.
//

#ifndef WCLDataMacro_h
#define WCLDataMacro_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**个推*/
#ifdef DEBUG
static NSString*const kGtAppId  = @"ME3je54kfv5npEQPFq7gh1";
static NSString*const kGtAppKey  =@"eR2b309dwR9tHhVrlF9dk6";
static NSString*const kGtAppSecret = @"Rd8buZiRVS6eJFKBC9oAv3";
#else
static NSString*const kGtAppId  = @"LtNtcjNIOe6Yj7JyJ1eFk9";
static NSString*const kGtAppKey  =@"EGj1lyD0BO89pks8VXeHs1";
static NSString*const kGtAppSecret = @"J5UR6eP2Ym6e4mvO1J5JH1";
#endif
/* MBK  KEY */
static NSString *const BMK_DISTRIBUTION_KEY    = @"";
/* WX 微信*/
//static NSString *const WX_Key                  = @"wxc03c6d0d6a10cf18";
static NSString *const WX_Key                  = @"wxde304ec90e9db692";


static NSString *const WX_Secret               = @"";
/* QQ  */
static NSString *const QQ_Key                  = @"";
static NSString *const QQ_Secret               = @"";
/* 新浪微博  */
static NSString *const SINA_Key                = @"193484684";
static NSString *const SINA_Secret             = @"27049a63f30eaf0047241e320134c08d";
static NSString *const SINA_RedirectUri             = @"http://yjwang.wamlle.com";

/* 支付宝 */
static NSString *const AP_Key                  = @"";
static NSString *const AP_Secret               = @"";
/* SHARE SDK */
static NSString *const ShareSDK_Key            = @"";
static NSString *const ShareSDK_Secret         = @"";
/* BUG_TGS */
static NSString *const Bug_Tags_Develop_Key    = @"";
static NSString *const Bug_Tags_Develop_Screct = @"";

static NSString *const Bug_Tags_Release_Key    = @"";
static NSString *const Bug_Tags_Release_Screct = @"";
/* 魔窗 */
static NSString *const Mochuange_Key           = @"";

/* talk data */
static NSString *const TalkData_Key            = @"";;

/* 极光推送 */
static NSString *const Jiguang_Key             = @"";
static NSString *const Jiguang_Secret          = @"";

static NSString *const NO_FIRST_LAUNCH_KEY         = @"IS_FIRST_LAUNCH_KEY";
static CGFloat   const kStatusBarHeight      = 20;
static CGFloat   const kBottomBarHeight      = 49;
static CGFloat   const kNavigationbarHeight  = 64;
static CGFloat   const Height_CollectionView = 30;
static CGFloat   const buttonHeight          = 45;

static NSInteger Tab_bar_Tag                 = 4444;

static CGFloat const scrollLimitSpace        = 30;
//间距
static CGFloat const space                   = 10;
static CGFloat const comments_left_space     = 40;
static CGFloat const space_middle            = 15;
static CGFloat const scroll_top              = 70;
static CGFloat const shadows_space           = .5;
///H5 URL

/**
 *  小心有空格
 */
//static NSString *const AppOfVersion_URL          = @"https://itunes.apple.com/lookup?id=1214306170";
static NSString *const App_Notification_Version  = @"App_Notification_Version";
static NSString *const AppOfAppstore_URL         = @"https://itunes.apple.com/us/app/百大悦城/id1084967248?l=zh&ls=1&mt=8";
typedef NS_ENUM(NSInteger,refundApplyType) {
    //仅退款
    REFUND,
    //退货退款
    RETURN,
    //优惠券退款
    COUPON
};
typedef NS_ENUM(NSInteger,MineTicketType) {
    //未使用
    MineTicketUNUSE,
    //已使用
    MineTicketUSE,
    //已过期
    MineTicketEXPIRE
};
typedef NS_ENUM(NSInteger,NavigationType) {
    NavigationTypeHome = 0,
    NavigationTypeCatgory,
    NavigationTypeGoodsDetail,
    NavigationTypeGoodList
};

// 商品详情类型
typedef NS_ENUM(NSInteger, ProductStyle){
    // 基本类型
    ProductStyleNormal,
    // 秒杀
    ProductStyleRush,
};
// 轮播图类型
typedef NS_ENUM(NSInteger, CarouselStyle){
    // 商品详情
    CarouselStyleGoods,
    // web连接
    CarouselStyleLink,
    // 分类
    CarouselStyleCate,
    // 新人专享
    CarouselStyleNovice,
    // 礼包专区
    CarouselStyleGift,
    // 其它
    CarouselStyleOther,
};
typedef NS_CLOSED_ENUM(NSInteger, ProductListStyle) {
    ProductListStyleGift = 1, // 礼包专区
    ProductListStyleBrand = 3, //品牌专区
    ProductListStyleNew = 4,  //新人专享
    ProductListStyleClassify, // 产品二级分类
};
#endif /* WCLDataMacro_h */
