//
//  BaseRefreshTool.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  集成刷新控件
 */
typedef NS_ENUM(NSUInteger, ATRefreshOption) {
    ATRefreshNone = 0,
    ATHeaderRefresh = 1 << 0,
    ATFooterRefresh = 1 << 1,
    ATHeaderAutoRefresh = 1 << 2,
    ATFooterAutoRefresh = 1 << 3,
    ATFooterDefaultHidden = 1 << 4,
    ATRefreshDefault = (ATHeaderRefresh | ATHeaderAutoRefresh | ATFooterRefresh | ATFooterDefaultHidden),
};
static NSString *FDMSG_Home_DataRefresh                      = @"数据加载中...";
static NSString *FDMSG_Home_DataEmpty                        = @"数据空空如也...";
static NSString *FDNoNetworkMsg                              = @"无网络连接,请检查网络设置";
#define defaultDataEmpty [UIImage imageNamed:@"icon_data_empty"]//空数据图片
#define defaultDataLoad [UIImage imageNamed:@"icon_data_load"]//
#define defaultNetError [UIImage imageNamed:@"icon_net_error"]//无网络图片

@interface BaseRefreshTool : NSObject<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
+(BaseRefreshTool *)shareInterface;
/**@param scrollView 空界面所在scrollView
@param image 空界面图片
@param title 空界面标题
*/
- (void)setupEmpty:(UIScrollView *)scrollView image:(UIImage *)image title:(NSString *)title;
- (void)setupEmpty:(UIScrollView *)scrollView;
/**
 @brief 设置刷新控件 子类可在refreshData中发起网络请求, 请求结束后回调endRefresh结束刷新动作
 @param scrollView 刷新控件所在scrollView
 @param option 刷新空间样式
 */
- (void)setupRefresh:(UIScrollView *)scrollView option:(ATRefreshOption)option completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
