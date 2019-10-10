//
//  BaseCommentCell.h
//  car
//
//  Created by Sunsgne on 2018/5/10.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEEStarRating.h"
#import "CommentModel.h"
#import "PictureContainerView.h"

@interface BaseCommentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *personImg;
@property (nonatomic, strong) UILabel *personNameLabel;
@property (nonatomic, strong) LEEStarRating *scoreImg;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *sizeLabel;

@property (nonatomic, strong) CommentModel *model;

@property (nonatomic, strong) PictureContainerView *picView;

@end
