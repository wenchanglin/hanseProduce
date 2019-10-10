//
//  WCLCateNavigationView.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/28.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCLCateNavigationView : UIView
- (instancetype)initWithFrame:(CGRect)frame navigationType:(NavigationType)navigationType;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *shangpinButton;
@property(nonatomic,strong)    UIView *lineView;
@property (nonatomic, strong) UIButton *pingjiaButton;
@property (nonatomic, strong) UIButton *xiangqingButton;
@property (nonatomic, strong) UIButton *buycarButton;
@property (nonatomic, strong) UIButton *messageButton;

//@property (nonatomic, strong) UILabel *searchLabel;

/**
 *  修改颜色
 */
- (void)changeColorWithState:(BOOL)state;

- (void)transFormMassageButtonOrgin;
@end

NS_ASSUME_NONNULL_END
