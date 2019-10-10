//
//  WCLHomeBannerModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeThreePicModel : NSObject
@property(nonatomic,assign)NSInteger cate_type;
@property(nonatomic,strong)NSString* img;
@property(nonatomic,assign)NSInteger itemId;
@property(nonatomic,assign)NSInteger p_id;
@property(nonatomic,assign)NSInteger pr_sort;
@property(nonatomic,assign)NSInteger pr_status;
@property(nonatomic,strong)NSString* type;
@property (nonatomic, assign)CarouselStyle style;
+(void)getControllerForStyle:(CarouselStyle)style itemid: (NSString*)iid withBlock: (void(^)(UIViewController *vc, BOOL isPush))block;

@end

NS_ASSUME_NONNULL_END
