//
//  CenterAlterController1.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/28.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CenterAlterBlock)(void);

NS_ASSUME_NONNULL_BEGIN

/// 带标题+按钮的弹窗控制器
@interface CenterAlterController : UIViewController

/// 初始化只带取消按钮的弹窗
/// @param title 标题
/// @param msg 描述
/// @param cancelTitle 取消按钮title----当为nil时,不显示此按钮
/// @param cancelBlock 取消block
-(instancetype)initWithTitle: (nullable NSString *)title message:(nullable NSAttributedString *)msg cancelButtonTitle:(nullable NSString*)cancelTitle handle:(nullable CenterAlterBlock)cancelBlock;

/// 初始化只带确定按钮的弹窗
/// @param title 标题
/// @param msg 描述
/// @param okTitle 确定按钮title----当为nil时,不显示此按钮
/// @param okBlock 确定block
-(instancetype)initWithTitle: (nullable NSString *)title message:(nullable NSAttributedString *)msg okButtonTitle:(nullable NSString*)okTitle handle:(nullable CenterAlterBlock)okBlock;

/// 初始化取消+确定按钮的弹窗
/// @param title 标题
/// @param msg 描述
/// @param cancelTitle 取消按钮title----当为nil时,不显示此按钮
/// @param cancelBlock 取消block
/// @param okTitle 确定按钮title----当为nil时,不显示此按钮
/// @param okBlock 确定block
-(instancetype)initWithTitle: (nullable NSString *)title message:(nullable NSAttributedString *)msg cancelButtonTitle:(nullable NSString*)cancelTitle cancelHandle:(nullable CenterAlterBlock)cancelBlock okButtonTitle: (nullable NSString *)okTitle okHandle:(nullable CenterAlterBlock)okBlock;

/// 初始化取消+确定按钮的弹窗--可以控制点击确定是否dismiss
/// @param title 标题
/// @param msg 描述
/// @param cancelTitle 取消按钮title----当为nil时,不显示此按钮
/// @param cancelBlock  取消block
/// @param okTitle 确定按钮title----当为nil时,不显示此按钮
/// @param clickOKDismiss 点击确定按钮是,是否dismiss
/// @param okBlock 确定block
-(instancetype)initWithTitle: (nullable NSString *)title message:(nullable NSAttributedString *)msg cancelButtonTitle:(nullable NSString*)cancelTitle cancelHandle:(nullable CenterAlterBlock)cancelBlock okButtonTitle: (nullable NSString *)okTitle clickOKDismiss: (BOOL)clickOKDismiss okHandle:(nullable CenterAlterBlock)okBlock;

-(void)showFromSourceController: (nonnull UIViewController *)source;
@end

NS_ASSUME_NONNULL_END
