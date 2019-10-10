//
//  YBLMethodTools.h
//  YBL365
//
//  Created by wen on 2016/12/17.
//  Copyright © 2016年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YBLSystemSocialModel.h"

@class YBLAdsModel;

static NSString  *animation_key_shake = @"animation_key_shake";
static NSString  *animation_key_3droation = @"animation_key_3droation";
@interface YBLMethodTools : NSObject

+ (NSMutableAttributedString *)getJoinVisitAttributedStringWithJoin:(NSString *)join
                                                          visitTime:(NSString *)visit
                                                      componeString:(NSString *)componeString;

+ (int)getRandomNumber:(int)from to:(int)to;

+ (NSString *)getAppVersion;

+ (NSString *)getAppBuildNumber;
    
+ (void)OpenURL:(NSURL *)url;


+ (float)getCurrentPriceWithCount:(NSInteger)count InPriceArray:(NSArray *)priceArray;

+ (void)addAnimationWith:(UIView *)view;

+ (void) popAnimationWithView:(UIView*)aView;

+(CABasicAnimation *) AlphaLight:(float)time;

+ (CATransform3D)transformFirstViewLayer;

+ (CATransform3D)transformSecondViewLayer;

+ (NSMutableArray *)getSeckillTimeWithNewTime:(NSString *)time;
/**生成二维码*/
// QRCode
+ (UIImage *)generateQRCodeWithInputMessage:(NSString *)inputMessage
                                      Width:(CGFloat)width
                                     Height:(CGFloat)height;
+ (UIImage *)generateQRCodeWithInputMessage:(NSString *)inputMessage
                                      Width:(CGFloat)width
                                     Height:(CGFloat)height
                             AndCenterImage:(UIImage *)centerImage;
+ (NSString *)decodeQRCodeWithPhotoCodeImage:(UIImage *)codeImage;
//条形码BarCode
+ (UIImage *)generateBarcodeWithInputMessage:(NSString *)inputMessage
                                       Width:(CGFloat)width
                                      Height:(CGFloat)height;


+ (UIImage *)addQRCImage:(UIImage *)qrcImage ToImage:(UIImage *)image;

+ (UIImage *)addTextLabel:(UILabel *)textLabel AndQrcImage:(UIImage *)qrcImage ToGoodImage:(UIImage *)goodImage;

+ (void)transformOpenView:(UIView *)view
                SuperView:(UIView *)sview
                  fromeVC:(UIViewController *)vc
                      Top:(CGFloat)top;

+ (void)transformCloseView:(UIView *)view
                 SuperView:(UIView *)sview
                   fromeVC:(UIViewController *)vc
                       Top:(CGFloat)top
                completion:(void (^ )(BOOL finished))completion;

+ (void)callWithNumber:(NSString *)number;
/**id转json字符串*/
+(NSString*)ObjectTojsonString:(id)object;
// 字典转json字符串方法
+(NSString *)convertToJsonData:(NSDictionary *)dict;
/**转换时间为昨天，今天*/
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate;
/**某个时间转成时间戳*/
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//格式化小数 四舍五入类型
+(NSString *)decimalwithFormat:(NSString *)format  floatV:(float)floatV;
+ (UIButton *)getContactKefuButtonWithFrame:(CGRect)frame;

+ (UIButton *)getNextButtonWithFrame:(CGRect)frame;

+ (UIButton *)getFurtureMoneyButtonWithFrame:(CGRect)frame;

+ (UIButton *)getFangButtonWithFrame:(CGRect)frame;

+ (UIView *)addLineView:(CGRect)frame;

+ (UIView *)getSuperShadowViewWithFrame:(CGRect)frame;

+ (void)addLeftShadowToView:(UIView *)view;

+ (void)addTopShadowToView:(UIView *)view;

+ (void)addTopShadowToGoodView:(UIView *)view;

+ (UIButton *)buttonWithImage:(NSString *)imageName title:(NSString *)title subtitle:(NSString *)subTitle litTitle:(NSString *)litTitle;

+ (NSArray *)getRowCount:(NSInteger)count;

+ (void)pushVc:(UIViewController *)Vc withNavigationVc:(UINavigationController *)navigationVc;

+ (void)popVc:(UIViewController *)Vc withNavigationVc:(UINavigationController *)navigationVc;
+(CGRect)jisuanTextHeightForString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont*)font;
+ (NSString *)dateTimeDifferenceWithEndTime:(NSString *)endTime;

+ (NSString *)diffDayOf:(NSString *)beginTime andEndTime:(NSString*)endTime;

+ (NSInteger)getGoodManageStatusWith:(NSString *)value;

+ (void)headerRefreshWithTableView:(id )view completion:(void (^)(void))completion;

+ (void)footerRefreshWithTableView:(id )view completion:(void (^)(void))completion;

+ (void)footerAutoRefreshWithTableView:(id )view completion:(void (^)(void))completion;
+ (void)footerNormalRefreshWithTableView:(id )view completion:(void (^)(void))completion;

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay dateFormatter:(NSDateFormatter *)dateFormatter;






+ (BOOL)popToFoundVCFrom:(UIViewController *)fromeVC;

+ (BOOL)popToMyPurchaseVCFrom:(UIViewController *)fromeVC;

+ (BOOL)popToHomeBarFromEditPurchaseVC:(UIViewController *)vc ;

+ (void)dismissViewControllerToRoot:(UIViewController *)Vc;

+ (void)pushVC:(UIViewController *)Vc FromeUndefineVC:(UIViewController *)superVC;

+ (NSString *)getStaffRoleNamesWithArray:(NSArray *)array;

+ (NSString *)getStaffRoleValueWithArray:(NSArray *)array;

+ (void)removeSearchBarBackgroundColorWithBar:(UIView *)bar;

+ (void)changeSearchBarCancleButton:(UIView *)bar;

+ (NSString *)getFullAppendingAddressWithArray:(NSMutableArray *)selectArray;

+ (NSString *)getCachImageSize;

+ (void)cleanImageCach;

+ (BOOL)checkLoginWithVc:(UIViewController *)Vc;
+(NSString *)formatFloat:(float)f;

+ (UIButton *)getButtonWithImage:(NSString *)imageName;

+ (YBLButton *)getTopAndCommandButton;

/********   New Method  ********/
+(BOOL)judgePassWordLegal:(NSString *)pass;
+ (BOOL)checkPhone:(NSString *)phoneNumber;
+ (BOOL)checkEmail:(NSString *)email;
+ (BOOL)checkIsChinese:(NSString *)string;
+ (void)setStatusBarBackgroundColor:(UIColor *)color;
+ (NSString *)transform:(NSString *)chinese;
+ (NSString *)getAppendingStringWithArray:(NSArray *)array appendingKey:(NSString *)key;
+ (NSString *)getAppendingTitleStringWithArray:(NSArray *)array appendingKey:(NSString *)key;
+ (NSString *)getAppendingShippingmentTitleStringWithArray:(NSArray *)array appendingKey:(NSString *)key;
+ (NSString *)getAppendingPaymentTitleStringWithArray:(NSArray *)array appendingKey:(NSString *)key;
+ (void)pushWebVcFrom:(UIViewController *)Vc URL:(NSString *)URL title:(NSString *)title string:(NSString*)string type:(NSString*)type buystate:(NSString*)state activityid:(NSNumber*)huodongid;
+ (NSString *)replaceNYRDataStringWith:(NSString *)dataString;
+ (void)cleanNotificationNumber;

+ (NSString *)updateURL:(NSString *)url versionWithSiganlNumber:(NSInteger)number;
+ (NSMutableArray *)getRowAppendingIndexPathsWithIndex:(NSInteger)index_from appendingCount:(NSInteger)appendingCount inSection:(NSInteger)inSection;
+ (NSMutableArray *)getSectionAppendingIndexPathsWithIndex:(NSInteger)index_from appendingCount:(NSInteger)appendingCount inSection:(NSInteger)inSection;
+ (BOOL)isSatisfyPrestrainDataWithAllcount:(NSInteger)allCount currentRow:(NSInteger)currentRow;
+ (YBLButton *)getImageTextButtonWithText:(NSString *)text buttonSize:(CGSize)buttonSize;
+ (NSString *)changeToNiMing:(NSString *)name;

+ (CABasicAnimation *)getShakeAnimation;
+ (CABasicAnimation *)get3DRotationAnimation;
+ (CABasicAnimation *)getScaleAnimationScale:(CGFloat)scale;
+ (void)copyString:(NSString *)copyString;
+ (void)handleAdsModel:(YBLAdsModel *)adsModel Vc:(UIViewController *)Vc;
+ (BOOL)isPureInt:(NSString*)string;
+ (BOOL)isPureFloat:(NSString*)string;
+ (NSString*)getTimeNow;
/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+(void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;
@end
