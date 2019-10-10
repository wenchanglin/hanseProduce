//
//  CenterAlterController1.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/28.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "CenterAlterController.h"
#import "UIViewController+CutomAlter.h"
@interface CenterAlterController ()
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *contentLabel;
@property(nonatomic, strong)CALayer *lineLayer;
@property(nonatomic, strong)UIButton *cancelButton;
@property(nonatomic, strong)UIButton *okButton;
@property(nonatomic, assign)BOOL hasOkButton;
@property(nonatomic, assign)BOOL hasCancelButton;
@property(nonatomic, assign)BOOL clickOKDismiss;
@property(nonatomic, strong, nullable)NSString *altertitle;
@property(nonatomic, strong, nullable)NSAttributedString *message;
@property(nonatomic, strong, nullable) CenterAlterBlock cancelBlock;
@property(nonatomic, strong, nullable) CenterAlterBlock okBlock;
@end

@implementation CenterAlterController

-(instancetype)initWithTitle:(NSString *)title message:(NSAttributedString *)msg cancelButtonTitle:(NSString *)cancelTitle handle:(CenterAlterBlock)cancelBlock {
    self = [self initWithTitle:title message:msg cancelButtonTitle:cancelTitle cancelHandle:cancelBlock okButtonTitle:nil clickOKDismiss:true okHandle:nil];
    return self;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSAttributedString *)msg okButtonTitle:(NSString *)okTitle handle:(CenterAlterBlock)okBlock {
    self = [self initWithTitle:title message:msg cancelButtonTitle:nil cancelHandle:nil okButtonTitle:okTitle clickOKDismiss:true okHandle:okBlock];
    return self;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSAttributedString *)msg cancelButtonTitle:(NSString *)cancelTitle cancelHandle:(CenterAlterBlock)cancelBlock okButtonTitle:(NSString *)okTitle okHandle:(CenterAlterBlock)okBlock {
    self = [self initWithTitle:title message:msg cancelButtonTitle:cancelTitle cancelHandle:cancelBlock okButtonTitle:okTitle clickOKDismiss:true okHandle:okBlock];
    return self;
}

-(instancetype)initWithTitle:(NSString *)title message:(NSAttributedString *)msg cancelButtonTitle:(NSString *)cancelTitle cancelHandle:(CenterAlterBlock)cancelBlock okButtonTitle:(NSString *)okTitle clickOKDismiss:(BOOL)clickOKDismiss okHandle:(CenterAlterBlock)okBlock {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.altertitle = title;
        self.message = msg;
        [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        [self.okButton setTitle:okTitle forState:UIControlStateNormal];
        self.hasOkButton = okTitle != nil;
        self.hasCancelButton = cancelTitle != nil;
        self.cancelBlock = cancelBlock;
        self.okBlock = okBlock;
        self.clickOKDismiss = clickOKDismiss;
        [self configUI];
    }
    return self;
}

-(void)showFromSourceController: (nonnull UIViewController *)source {
    if (source == nil) {
        source = UIApplication.topViewController;
    }
    [source customCenterAlterViewController:self touchedCoverDismiss:false];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat space = 16;
    if (self.altertitle != nil || self.altertitle.length > 0) {
        self.titleLabel.top = space;
        self.contentLabel.top = self.titleLabel.bottom + (10);
    } else {
        self.titleLabel.top = 0;
        self.contentLabel.top = 0;
    }
    if (self.message != nil || self.message.string.length > 0) {
        self.lineLayer.top = self.contentLabel.bottom + space;
    } else {
        self.lineLayer.top = self.contentLabel.bottom;
    }
    if (self.hasOkButton && self.hasCancelButton) {
        self.cancelButton.left = (15);
        self.cancelButton.top = self.lineLayer.bottom + (14);
        self.okButton.frame = CGRectOffset(self.cancelButton.frame, self.cancelButton.width + (15), 0);
    } else if (self.hasCancelButton && !self.hasOkButton) {
        self.cancelButton.centerX = self.view.width * 0.5;
        self.cancelButton.top = self.lineLayer.bottom + (14);
    } else if (!self.hasCancelButton && self.hasOkButton) {
        self.okButton.centerX = self.view.width * 0.5;
        self.okButton.top = self.lineLayer.bottom + (14);
    }
}

-(void)configUI {
    CGFloat edgeSpace = (50);
    CGFloat vw = UIScreen.mainScreen.bounds.size.width - edgeSpace * 2;
    CGFloat th = 0;
    CGFloat space = (16);
    CGFloat totalHeight = 0;
    if (self.altertitle != nil || self.altertitle.length > 0) {
        self.titleLabel.text = self.altertitle;
        CGSize ts = [self.titleLabel sizeThatFits:CGSizeMake(vw - space * 2, 140)];
        self.titleLabel.size = ts;
        self.titleLabel.centerX = vw * 0.5;
        th = ts.height;
        [self.view addSubview:self.titleLabel];
    } else {
        self.titleLabel.width = vw;
        self.titleLabel.height = 0;
        self.titleLabel.centerX = vw * 0.5;
        [self.view addSubview:self.titleLabel];
    }
    totalHeight = (th > 0) ? (th + space + (10)) : 0;
    CGFloat ch = 0;
    if (self.message != nil || self.message.string.length > 0) {
        self.contentLabel.attributedText = self.message;
        CGSize cs = [self.contentLabel sizeThatFits:CGSizeMake(vw - space * 2, 450)];
        self.contentLabel.width = vw - space * 2;
        self.contentLabel.height = cs.height;
        self.contentLabel.centerX = vw * 0.5;
        ch = cs.height;
        [self.view addSubview:self.contentLabel];
    }
    CGFloat chh = (ch > 0) ? (ch + (10) * 2) : 0;
    totalHeight += chh;
    if (self.hasCancelButton) {
        [self.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.hasOkButton) {
        [self.okButton addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.okButton];
    }
    if (self.hasOkButton || self.hasOkButton) {
        self.lineLayer.width = vw;
        self.lineLayer.height = 1;
        [self.view.layer addSublayer:self.lineLayer];
        totalHeight += 1;
    }
    CGFloat bh = 0;
    CGFloat bw = 0;
    CGFloat bbottom = 0;
    if (self.hasOkButton && self.hasCancelButton) {
        bh = (36);
        bw = (vw - (45)) * 0.5;
        bbottom = (14);
        [self.view addSubview:self.cancelButton];
        [self.view addSubview:self.okButton];
     } else if (!self.hasCancelButton && !self.hasOkButton) {
         bh = 0;
         bw = 0;
         bbottom = 0;
     } else {
         bh = (36);
         bw = vw - (30);
         bbottom = (14);
         [self.view addSubview:self.hasOkButton ? self.okButton : self.cancelButton];
     }
    self.cancelButton.width = bw;
    self.cancelButton.height = bh;
    UIImage *img1 = [[UIImage imageWithColor:UIColor.e size:self.cancelButton.size] imageByRoundCornerRadius:bh * 0.5];
    [self.cancelButton setBackgroundImage:img1 forState:UIControlStateNormal];
    [self.cancelButton setBackgroundImage:img1 forState:UIControlStateHighlighted];
    
    self.okButton.width = bw;
    self.okButton.height = bh;
    UIImage *img2 = [[UIImage linerThemeImageWithSize:self.okButton.size] imageByRoundCornerRadius:bh * 0.5];
    [self.okButton setBackgroundImage:img2 forState:UIControlStateNormal];
    [self.okButton setBackgroundImage:img2 forState:UIControlStateHighlighted];
    totalHeight += (bbottom * 2 + bh);
    self.preferredContentSize = CGSizeMake(vw, totalHeight);
}

-(void)cancelAction {
    WEAK
    [self dismissViewControllerAnimated:true completion:^{
        STRONG
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }];
}

-(void)okAction {
    if (self.clickOKDismiss) {
        WEAK
        [self dismissViewControllerAnimated:true completion:^{
            STRONG
            if (self.okBlock) {
                self.okBlock();
            }
        }];
        return;
    }
    if (self.okBlock) {
        self.okBlock();
    }
}

-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColor.f3;
        _titleLabel.font = kRegularFont((18));
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
-(UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        
    }
    return _contentLabel;
}
-(CALayer *)lineLayer {
    if (_lineLayer == nil) {
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.backgroundColor = UIColor.e1.CGColor;
    }
    return _lineLayer;
}
-(UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelButton setTitleColor:UIColor.f6 forState:UIControlStateNormal];
        [_cancelButton setTitleColor:UIColor.f6 forState:UIControlStateHighlighted];
        _cancelButton.titleLabel.font = kMediumFont((14));
    }
    return _cancelButton;
}
-(UIButton *)okButton {
    if (_okButton == nil) {
        _okButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_okButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_okButton setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
        _okButton.titleLabel.font = kMediumFont((14));
    }
    return _okButton;
}
@end
