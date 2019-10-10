

#import <UIKit/UIKit.h>


@interface YBLHomeNavigationView : UIView

- (instancetype)initWithFrame:(CGRect)frame navigationType:(NavigationType)navigationType;

@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UILabel *searchLabel;

/**
 *  修改颜色
 */
- (void)changeColorWithState:(BOOL)state;

- (void)transFormMassageButtonOrgin;

@end
