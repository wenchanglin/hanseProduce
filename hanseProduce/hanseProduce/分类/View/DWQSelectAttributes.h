//
//  DWQSelectAttributes.h
//  DWQSelectAttributes
//
//  Created by 杜文全 on 15/5/21.
//  Copyright © 2015年 com.sdzw.duwenquan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SelectAttributesDelegate <NSObject>
@required
-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn;

@end

@interface DWQSelectAttributes : UIView

//已经选中的数组
@property (nonatomic, strong) NSArray *canSelectArray;

/**
 初始可以选择的数组
 */
@property (nonatomic, strong) NSArray *primaryCanChooseArray;


@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *attributesArray;

@property(nonatomic,strong)UIButton *selectBtn;

@property(nonatomic,strong)UIView *packView;
@property(nonatomic,strong)UIView *btnView;

@property(nonatomic,assign)id<SelectAttributesDelegate> delegate;

@property (nonatomic, copy) void(^didChooseTagBlock)(NSString *title, NSInteger index, BOOL flag);

-(instancetype)initWithTitle:(NSString *)title titleArr:(NSArray *)titleArr andFrame:(CGRect)frame;


@end
