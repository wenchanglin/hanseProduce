//
//  WCLCateNavigationView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/28.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLCateNavigationView.h"
@interface WCLCateNavigationView()
@property (nonatomic, assign) NavigationType navigationType;

@end
@implementation WCLCateNavigationView
- (instancetype)initWithFrame:(CGRect)frame navigationType:(NavigationType)navigationType {
    if (self = [super initWithFrame:frame]) {
        
        _navigationType = navigationType;
        
        [self createSubViews];
    }
    return self;
}
/**
 *  修改颜色
 */
- (void)changeColorWithState:(BOOL)state {
    
    if (state) {
        self.backgroundColor=[UIColor whiteColor];
        [self.backButton setImage:[UIImage imageNamed:@"black_back"] forState:UIControlStateNormal] ;
        [self.messageButton setImage:[UIImage imageNamed:@"black_msg"] forState:UIControlStateNormal];
        [self.messageButton setTitleColor:YBLColor(47, 47, 47, 1.0) forState:UIControlStateNormal];
        [self.buycarButton setImage:[UIImage imageNamed:@"black_car"] forState:UIControlStateNormal];
        [self.pingjiaButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        
    }else {
        [self.backButton setImage:[UIImage imageNamed:@"detail_back"] forState:UIControlStateNormal] ;
        self.backButton.adjustsImageWhenHighlighted=NO;
        [self.messageButton setImage:[UIImage imageNamed:@"detail_msg"] forState:UIControlStateNormal];
        [self.messageButton setTitleColor:YBLColor(47, 47, 47, 1.0) forState:UIControlStateNormal];
        self.messageButton.adjustsImageWhenHighlighted = NO;
        [self.buycarButton setImage:[UIImage imageNamed:@"detail_car"] forState:UIControlStateNormal];
        self.buycarButton.adjustsImageWhenHighlighted=NO;
        [self.pingjiaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
}
- (void)createSubViews {
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(5,[ShiPeiIphoneXSRMax isIPhoneX]?35:20, 44, 44);
    self.backButton.layer.cornerRadius = self.backButton.height/2;
    self.backButton.layer.masksToBounds = YES;
    [self.backButton setImage:[UIImage imageNamed:@"detail_back"] forState:UIControlStateNormal] ;
    [self addSubview:self.backButton];
    self.shangpinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shangpinButton.frame = CGRectMake(self.width/2-69, [ShiPeiIphoneXSRMax isIPhoneX]?30:20, 44, 44);
    self.shangpinButton.centerY=self.backButton.centerY;
    [self.shangpinButton setTitle:@"" forState:UIControlStateNormal];
    [self.shangpinButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self.shangpinButton setTitleColor:[UIColor colorWithHexString:@"#E70014"] forState:UIControlStateSelected];
    self.shangpinButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.shangpinButton.tag=10;
    [self addSubview:self.shangpinButton];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(self.width/2-69, [ShiPeiIphoneXSRMax isIPhoneX]?30+40:20+40, 44, 2)];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#E70014"];
    [self addSubview:self.lineView];
    self.lineView.hidden = YES;
//    self.shangpinButton.hidden=YES;
    self.pingjiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pingjiaButton.frame = CGRectMake((self.width-80)/2, [ShiPeiIphoneXSRMax isIPhoneX]?30:20, 80, 44);
    self.pingjiaButton.centerY=self.backButton.centerY;
    [self.pingjiaButton setTitle:@"商品详情" forState:UIControlStateNormal];
    [self.pingjiaButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    self.pingjiaButton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    self.pingjiaButton.tag=11;
    [self addSubview:self.pingjiaButton];
    
    self.xiangqingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xiangqingButton.frame = CGRectMake(self.width/2+24, [ShiPeiIphoneXSRMax isIPhoneX]?30:20, 44, 44);
    self.xiangqingButton.centerY=self.backButton.centerY;
    [self.xiangqingButton setTitle:@"" forState:UIControlStateNormal];
    self.xiangqingButton.tag=12;
    [self.xiangqingButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self.xiangqingButton setTitleColor:[UIColor colorWithHexString:@"#E70014"] forState:UIControlStateSelected];
    self.xiangqingButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self addSubview:self.xiangqingButton];
//    self.xiangqingButton=YES;
    
//    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7.5, 15, 15)];
//    [self.searchButton addSubview:self.searchImageView];
//
//    self.searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.searchImageView.right+5, 0, self.searchButton.width-self.searchImageView.right-20, self.searchButton.height)];
//    self.searchLabel.font = YBLFont(14);
//    self.searchLabel.text = @"搜索商品";
//    [self.searchButton addSubview:self.searchLabel];
    self.buycarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buycarButton.frame = CGRectMake(self.width - 44 - 5-44, 20, 44, 44);
    self.buycarButton.centerY=self.shangpinButton.centerY;
    [self.buycarButton setImage:[UIImage imageNamed:@"detail_car"] forState:UIControlStateNormal];
    [self addSubview:self.buycarButton];
    
    self.messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageButton.frame = CGRectMake(self.width - 44 - 5, 20, 44, 44);
    self.messageButton.centerY=self.shangpinButton.centerY;
    [self.messageButton setImage:[UIImage imageNamed:@"detail_msg"] forState:UIControlStateNormal];
    [self addSubview:self.messageButton];
    self.backgroundColor = [UIColor clearColor];
        

    
    
    
}

- (UIBezierPath *)getShadowPath{
    //添加阴影
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOpacity = 0.4;//阴影透明度，默认0
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowRadius = 4;//阴影半径，默认3
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, self.height-1)];
    [path addLineToPoint:CGPointMake(self.width, self.height-1)];
    [path addLineToPoint:CGPointMake(self.width, self.height+2)];
    [path addLineToPoint:CGPointMake(0, self.height+2)];
    [path addLineToPoint:CGPointMake(0, self.height-1)];
    return path;
}

- (void)transFormMassageButtonOrgin{
    
    self.messageButton.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.messageButton.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
