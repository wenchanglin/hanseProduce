//
//  CountChangeView.m
//  manpinhy
//
//  Created by Sunsgne on 2018/6/7.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import "CountChangeView.h"

@interface CountChangeView ()<UITextFieldDelegate>
{
    UIButton *_addBtn,*_reduceBtn;
    CGFloat keyBoardHeight;
}

@end

@implementation CountChangeView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.maxInputNumber = 999;
        
        [self setup];
        
        //注册键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 键盘通知
//显示
- (void)keyboardWasShown:(NSNotification*)aNotification{
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.3f animations:^{
        
      keyBoardHeight = keyBoardFrame.size.height;
    }];
}
- (void)setup{
    CGFloat wid = 40;
    CGFloat height = 28;
    
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-wid, 0, wid, height)];
    [_addBtn setTitle:@"+" forState:0];
    _addBtn.titleLabel.font = kFont(18);
    [_addBtn setTitleColor:[UIColor grayColor] forState:0];
    _addBtn.backgroundColor = YBLColor(235, 235, 235, 1);
    [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(_addBtn.left-5-wid, 0, wid, height)];
    _textField.text = @"1";
    _textField.font = kFont(14);
    _textField.backgroundColor = YBLColor(235, 235, 235, 1);
    _textField.textColor = [UIColor grayColor];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.keyboardType = UIKeyboardTypePhonePad;
    _textField.jk_maxLength = 4;
    [_textField addTarget:self action:@selector(textValueDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_textField];
    
    self.currentCount = [_textField.text integerValue];
    
    _reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(_textField.left-5-wid, 0, wid, height)];
    [_reduceBtn setTitle:@"-" forState:0];
    _reduceBtn.titleLabel.font = kFont(18);
    [_reduceBtn setTitleColor:[UIColor grayColor] forState:0];
    _reduceBtn.backgroundColor = YBLColor(235, 235, 235, 1);
    [_reduceBtn addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceBtn];
}
#pragma mark - 
- (void)setMaxInputNumber:(NSInteger)maxInputNumber{
    _maxInputNumber = maxInputNumber;
    
    if (self.currentCount>maxInputNumber) {
        self.currentCount = maxInputNumber;
        _textField.text = [NSString stringWithFormat:@"%zd",self.currentCount];
    }

}
#pragma mark - 如果是易业商品需要做判断
- (void)setP_type:(NSNumber *)p_type{
    _p_type = p_type;
//    
//    if ([p_type integerValue] == 1) {
//        _addBtn.enabled = _reduceBtn.enabled = _textField.enabled = NO;
//    }else{
//        _addBtn.enabled = _reduceBtn.enabled = _textField.enabled = YES;
//    }
    
}
#pragma mark - ++
- (void)addAction:(UIButton *)btn{

    if (self.currentCount>=self.maxInputNumber) {
        return;
    }
    self.currentCount++;
    
    [self updateTheTextField];
    
}
#pragma mark - --
- (void)reduceAction:(UIButton *)btn{
    
    if (self.currentCount<=1) {
        return;
    }
    self.currentCount--;
    
    [self updateTheTextField];
    
}

//update
- (void)updateTheTextField{
    
    if (self.currentCount != 0) {
        
        if (self.countChangeBlock) {
            self.countChangeBlock(self.currentCount);
        }
    }else{
        self.currentCount = 1;
    }
    
    _textField.text = [NSString stringWithFormat:@"%zd",self.currentCount];
}
#pragma mark - 编辑中
- (void)textValueDidChange:(UITextField *)td{
    
    NSLog(@"%@",td.text);
    
//    if ([td.text integerValue]>=1000) {
//        td.text = @"999";
//    }
//    if ([td.text integerValue]==0) {
//        td.text = @"1";
//    }
//
    
    if ([td.text integerValue]>0 && [td.text integerValue]<=self.maxInputNumber) {
        self.currentCount = [td.text integerValue];
        
        if (self.countChangeBlock) {
            self.countChangeBlock(self.currentCount);
        }
    }
 
}
#pragma mark- 编辑结束
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.text integerValue]>=self.maxInputNumber) {
        textField.text = [NSString stringWithFormat:@"%zd",self.maxInputNumber];
    }
//    if ([textField.text integerValue] == 0) {
//        textField.text = @"1";
//    }
    self.currentCount = [textField.text integerValue];
    
    if (self.tfEndEditingBlock) {
        self.tfEndEditingBlock();
    }

    [self updateTheTextField];
}
#pragma mark - 键盘弹起 视图上移block
//数字键盘只有260
#define normalTextKeyBoardHeight 270
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (self.tfBeginEditingBlock) {
        self.tfBeginEditingBlock(keyBoardHeight<=normalTextKeyBoardHeight?normalTextKeyBoardHeight:keyBoardHeight);
    }
    
}
#define NUM @"0123456789"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}
@end
