//
//  WCLHomeClassifyModel.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/23.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLHomeClassifyModel : NSObject
@property(nonatomic,assign)NSInteger cate_id;
@property(nonatomic,strong)NSString* img;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger cate_sort;
@property(nonatomic,strong)NSString* cate_title;
@property(nonatomic,assign)NSInteger parent_id;
/**
 需要跳转的url
 */
@property (nonatomic, copy)       NSString *url;

@end

NS_ASSUME_NONNULL_END
