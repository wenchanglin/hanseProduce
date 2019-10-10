//
//  BaseCommentCell.m
//  car
//
//  Created by Sunsgne on 2018/5/10.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import "BaseCommentCell.h"
@implementation BaseCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    self.personImg = [[UIImageView alloc] init];
    self.personImg.contentMode = UIViewContentModeScaleAspectFill;
    self.personImg.clipsToBounds = YES;
    self.personImg.layer.cornerRadius = 20;
    self.personImg.clipsToBounds = YES;
    [self.contentView addSubview:self.personImg];
    
    self.personNameLabel = [[UILabel alloc] init];
    self.personNameLabel.font = kFont(15);
    self.personNameLabel.textColor = [UIColor f3];
    [self.contentView addSubview:self.personNameLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = kFont(12);
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLabel];
    
    self.scoreImg = [[LEEStarRating alloc] init];
    self.scoreImg.spacing = 2;
    self.scoreImg.checkedImage = [UIImage imageNamed:@"full4@2x"];
    self.scoreImg.uncheckedImage = [UIImage imageNamed:@"blank4@2x"];
    self.scoreImg.type = RatingTypeUnlimited;
    self.scoreImg.touchEnabled = YES;
    self.scoreImg.slideEnabled = YES;
    self.scoreImg.maximumScore = 5.0f;
    self.scoreImg.minimumScore = 0.0f;
    [self.contentView addSubview:self.scoreImg];
    
    self.sizeLabel = [[UILabel alloc] init];
    self.sizeLabel.textColor = [UIColor grayColor];
    self.sizeLabel.font = kFont(12);
    [self.contentView addSubview:self.sizeLabel];
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = kFont(13);
    self.messageLabel.textColor = [UIColor f3];
    [self.contentView addSubview:self.messageLabel];
    
    
    self.picView = [[PictureContainerView alloc] init];
    [self.contentView addSubview:self.picView];
    
    CGFloat padding = 15.f;
    self.personImg.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, padding).widthIs(40).heightEqualToWidth();
    self.personNameLabel.sd_layout.leftSpaceToView(self.personImg, 10).topEqualToView(self.personImg).widthIs(200).heightIs(20);
    self.scoreImg.sd_layout.leftEqualToView(self.personNameLabel).topSpaceToView(self.personNameLabel, padding/2).widthIs(70).heightIs(10);
    self.timeLabel.sd_layout.leftEqualToView(self.personImg).topSpaceToView(self.personImg, padding/2).heightIs(20);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:100];
    self.sizeLabel.sd_layout.leftSpaceToView(self.timeLabel, padding/2).topEqualToView(self.timeLabel).heightIs(20);
    [self.sizeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.messageLabel.sd_layout.leftEqualToView(self.personImg).rightSpaceToView(self.contentView, padding).topSpaceToView(self.timeLabel, padding).autoHeightRatio(0);
    
}

- (void)setModel:(CommentModel *)model{
    
    if (model.cmt_imgs.count!=0) {
        self.picView.picArray = model.cmt_imgs;
        self.picView.sd_layout.leftEqualToView(self.personImg).topSpaceToView(self.messageLabel, 15);
        [self setupAutoHeightWithBottomView:self.picView bottomMargin:15];
    }else{
        [self setupAutoHeightWithBottomView:self.messageLabel bottomMargin:15];
    }
    
    [self.personImg showImgUrl:model.headimg placeholder:DZImageNamed(@"loading_image1")];
    self.personNameLabel.text = model.user_name;
    self.timeLabel.text = model.cmt_gmt_create;
    self.scoreImg.currentScore = [model.cmt_score floatValue];
    self.scoreImg.userInteractionEnabled = NO;
    self.messageLabel.text = model.cmt_content;
    self.sizeLabel.text = [NSString stringWithFormat:@"%@",model.cmt_size];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
