//
//  ClassifyTwoCell.h
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassifyTwoCell : UICollectionViewCell
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *label;
-(void)setTitle:(NSString *)title imageUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
