//
//  CommentModel.h
//  car
//
//  Created by Sunsgne on 2018/5/10.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

/**
 评论用户id
 */
@property (nonatomic, strong) NSNumber *user_id;

/**
 评论内容
 */
@property (nonatomic, strong) NSString *cmt_content;

/**
 评分
 */
@property (nonatomic, strong) NSString *cmt_score;

/**
 时间
 */
@property (nonatomic, strong) NSString *cmt_gmt_create;

/**
 评论用户名
 */
@property (nonatomic, strong) NSString *user_name;

/**
 评论用户头像
 */
@property (nonatomic, strong) NSString *headimg;

/**
 //1 文本 2图片
 */
@property (nonatomic, strong) NSString *type;

/**
 购买的商品规格
 */
@property (nonatomic, strong) NSString *cmt_size;

/**
 评论图片数组
 */
@property (nonatomic, strong) NSArray *cmt_imgs;
@end
