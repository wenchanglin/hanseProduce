//
//  DWQSelectAttributes.m
//  DWQSelectAttributes
//
//  Created by 杜文全 on 15/5/21.
//  Copyright © 2015年 com.sdzw.duwenquan. All rights reserved.
//

#import "DWQSelectAttributes.h"
#import "SizeModel.h"
#import "UIButton+DZButton.h"

@implementation DWQSelectAttributes

-(instancetype)initWithTitle:(NSString *)title titleArr:(NSArray *)titleArr andFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.title = title;
        
        
    
        self.attributesArray = [NSArray arrayWithArray:titleArr];
        
        [self rankView];
    }
    return self;
}


-(void)rankView{
    
    self.packView = [[UIView alloc] initWithFrame:self.frame];
    self.packView.top = 0;
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, 25)];
    titleLB.text = self.title;
    titleLB.font = kFont(15);
    [self.packView addSubview:titleLB];
    
    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleLB.frame), SCREEN_WIDTH, 40)];
    [self.packView addSubview:self.btnView];
    
    int count = 0;
    float btnWidth = 0;
    float viewHeight = 0;
    for (int i = 0; i < self.attributesArray.count; i++) {
        
        SizePortotiesModel *model = self.attributesArray[i];
        
        NSString *btnName = model.attr_val_name;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bind_id = model.bind_id;
        
        [btn setBackgroundColor:[UIColor customGray]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:btnName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:kFont(12) forKey:NSFontAttributeName];
        CGSize btnSize = [btnName sizeWithAttributes:dict];
        
        btn.width = btnSize.width + 15;
        btn.height = btnSize.height + 12;
        
        if (i==0)
        {
            btn.left = 20;
            btnWidth += CGRectGetMaxX(btn.frame);
        }else{
            btnWidth += CGRectGetMaxX(btn.frame)+20;
            if (btnWidth > SCREEN_WIDTH) {
                count++;
                btn.left = 20;
                btnWidth = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.left += btnWidth - btn.width;
            }
        }
        btn.top += count * (btn.height+10)+10;
        
        viewHeight = CGRectGetMaxY(btn.frame)+10;
        
        [self.btnView addSubview:btn];
        
        btn.tag = 10000+i;
        
        if (model.forbiddin) {
            btn.enabled = NO;
            btn.alpha = 0.5;
        }else{
            btn.enabled = YES;
            btn.alpha = 1;
        }
        
    }
    self.btnView.height = viewHeight;
    self.packView.height = self.btnView.height+CGRectGetMaxY(titleLB.frame);
    
    self.height = self.packView.height;
    
    [self addSubview:self.packView];
}

- (void)setCanSelectArray:(NSArray *)canSelectArray{
    
    _canSelectArray = canSelectArray;
    if (!canSelectArray||canSelectArray.count==0) {
        return;
    }
    
    for (NSString *title in canSelectArray) {
        for (UIButton *btn in _btnView.subviews) {
            if ([btn.currentTitle isEqualToString:title]) {
                btn.selected = YES;
                btn.backgroundColor = [UIColor theme];
            }
        }
    }
}
- (void)setPrimaryCanChooseArray:(NSArray *)primaryCanChooseArray{
    _primaryCanChooseArray = primaryCanChooseArray;
    
    if (!primaryCanChooseArray||primaryCanChooseArray.count==0) {
        return;
    }
    
    for (NSString *title in primaryCanChooseArray) {
        for (UIButton *btn in _btnView.subviews) {
            if ([btn.currentTitle isEqualToString:title]) {
                btn.enabled = YES;
                btn.alpha = 1;
            }
        }
    }
}

- (void)btnClick:(UIButton *)btn{

    NSInteger tag = btn.tag - 10000;
    
    if (!btn.selected) {
        for (UIButton *b in _btnView.subviews) {
            if ([b isKindOfClass:[UIButton class]]) {
                b.selected = NO;
                b.backgroundColor = [UIColor customGray];
            }
        }

        btn.backgroundColor = [UIColor py_colorWithHexString:@"#ef766a"];
        btn.selected = YES;
    }else{
        btn.selected = NO;
        btn.backgroundColor = [UIColor customGray];
    }


    if (self.didChooseTagBlock) {
        self.didChooseTagBlock(btn.currentTitle, tag, btn.selected);
    }
}

@end
