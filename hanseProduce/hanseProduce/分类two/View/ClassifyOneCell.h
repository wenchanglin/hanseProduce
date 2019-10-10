//
//  ClassifyOneCell.h
//  hanseProduce
//
//  Created by 文长林 on 2019/10/8.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassifyOneCell : UICollectionViewCell
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
