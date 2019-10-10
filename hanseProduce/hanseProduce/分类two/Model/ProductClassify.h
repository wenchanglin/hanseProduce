//
//  ProductClassify.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/18.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 产品分类
 */
@interface ProductClassify : NSObject

@property(class, nonatomic, readonly) ProductClassify *all;
/**
 自身id
 */
@property (nonatomic,assign)       NSInteger cate_id;

/**
 父类id
 */
@property (nonatomic,assign)       NSInteger parent_id;

/**
 类型
 */
@property (nonatomic,assign)       NSInteger type;

/**
 排序
 */
@property (nonatomic, assign)      NSInteger cate_sort;

/**
 标题
 */
@property (nonatomic, copy)       NSString *cate_title;

/**
 图像url
 */
@property (nonatomic, copy, nullable)       NSString *img;



@end
NS_ASSUME_NONNULL_END
