//
//  WCLHomeBannerModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WCLHomeBannerModel : NSObject
@property(nonatomic,assign)NSInteger ca_id;
@property(nonatomic,strong)NSString*color_value;
@property(nonatomic,strong)NSString*img;
@property(nonatomic,strong)NSString* itemid;
@property(nonatomic,strong)NSString*video;
@property(nonatomic,strong)NSString*type;
@property(nonatomic,assign)BOOL isVideo;
@property (nonatomic, assign)CarouselStyle style;
+(void)getControllerForStyle:(CarouselStyle)style itemid: (NSString*)iid withBlock: (void(^)(UIViewController *vc, BOOL isPush))block;

@end

NS_ASSUME_NONNULL_END
