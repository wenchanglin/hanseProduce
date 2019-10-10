//
//  BaseRefreshTool.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/20.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "BaseRefreshTool.h"
@interface BaseRefreshTool()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSDate *lastRefreshDate;
@property (nonatomic, copy) NSString *emptyTitle;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIImage *emptyImage;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL reachable;
@end
@implementation BaseRefreshTool
{
    BOOL _isSetKVO;
}
static BaseRefreshTool * tool=nil;
+(BaseRefreshTool *)shareInterface{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool=[[BaseRefreshTool alloc]init];
    });
    return tool;
}
-(instancetype)init{
    if (self==[super init]) {
        
    }
    return self;
}
-(void)setupEmpty:(UIScrollView *)scrollView
{
    [self setupEmpty:scrollView image:defaultDataEmpty title:FDMSG_Home_DataEmpty];
}
- (void)setupEmpty:(UIScrollView *)scrollView image:(UIImage *)image title:(NSString *)title {
    scrollView.emptyDataSetSource = self;
    scrollView.emptyDataSetDelegate = self;
    self.emptyImage = image;
    self.emptyTitle = title;
    
    if (_isSetKVO) {
        return;
    }
    _isSetKVO = YES;
    if (scrollView.contentOffset.y >= -scrollView.mj_inset.top && scrollView.emptyDataSetVisible) {
        [NSObject cancelPreviousPerformRequestsWithTarget:scrollView selector:@selector(reloadEmptyDataSet) object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [scrollView reloadEmptyDataSet];
        });
        
    }
    
}
#pragma mark DZNEmptyDataSetSource DZNEmptyDataSetDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSString *text = self.isRefreshing ? FDMSG_Home_DataRefresh : self.emptyTitle;
    NSDictionary* attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName :self.isRefreshing ?[UIColor colorWithHexString:@"#f6f6f6"] :[UIColor colorWithHexString:@"#666666"],
                                 NSParagraphStyleAttributeName : paragraph};
//    if (![self reachable]) {
//        text = FDNoNetworkMsg;
//    }
    return [[NSMutableAttributedString alloc] initWithString:(text ? [NSString stringWithFormat:@"\r\n%@", text] : @"")
                                                  attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    UIImage *imageEmpty = self.isRefreshing ? defaultDataLoad : self.emptyImage;
    return self.reachable ?imageEmpty : defaultNetError;
}

#pragma mark - DZNEmptyDataSetDelegate

// 是否可以动画显示
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    
    return NO;//self.isRefreshing;
}
// 给图片添加动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *) scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.2;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return [ShiPeiIphoneXSRMax isIPhoneX]?-88/2:-64/2;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 1;
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (!self.isRefreshing) {
        [self headerRefreshing];
    }
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    
}
//- (BOOL)reachable{
//    return [WCLUserManageCenter shareInstance].isNoActiveNetStatus;
//}
#pragma mark - refresh 刷新处理
- (void)setupRefresh:(UIScrollView *)scrollView option:(ATRefreshOption)option completion:(void (^)(void))completion {
    self.scrollView = scrollView;
    if (ATRefreshNone == option) {
        [self headerRefreshing];
    }else{
        if (option & ATHeaderRefresh) {
            MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
                completion();
            }];
            header.automaticallyChangeAlpha = YES;
            header.lastUpdatedTimeLabel.hidden = YES;
            header.stateLabel.hidden = YES;
            NSMutableArray * images = [NSMutableArray array];
            for (int i = 1; i <= 35; i++) {
                @autoreleasepool {
                    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"下拉loading_%04d.png", i]];
                    [images addObject:image];
                };
                
            }
            if (images.count > 0) {
                [header setImages:@[images.firstObject] forState:MJRefreshStateIdle];
                [header setImages:images duration:1 forState:MJRefreshStateRefreshing];
            }
            
            if (option & ATHeaderAutoRefresh) {
                [self headerRefreshing];
            }
            scrollView.mj_header = header;
            
        }
        
        if (option & ATFooterRefresh) {
            
            MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
                completion();
            }];
            footer.stateLabel.hidden = NO;
            footer.labelLeftInset = -22;
            
            NSMutableArray * images = [NSMutableArray array];
            for (int i = 1; i <= 35; i++) {
                @autoreleasepool {
                    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"上拉loading_%04d.png", i]];
                    [images addObject:image];
                };
            }
            if (images.count > 0) {
                [footer setImages:@[images[0]] forState:MJRefreshStateIdle];
                [footer setImages:images duration:1.0f forState:MJRefreshStateRefreshing];
            }
            [footer setTitle:@"已经到底了" forState:MJRefreshStateNoMoreData];
            [footer setTitle:@"" forState:MJRefreshStatePulling];
            [footer setTitle:@"" forState:MJRefreshStateRefreshing];
            [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
            [footer setTitle:@"" forState:MJRefreshStateIdle];
            
            
            if (option & ATFooterAutoRefresh) {
                if (self.currentPage == 0) {
                    self.isRefreshing = YES;
                }
                [self footerRefreshing];
            }
            else if (option & ATFooterDefaultHidden) {
                footer.hidden = YES;
            }
            scrollView.mj_footer = footer;
        }
    }
}

- (void)headerRefreshing {
    
    self.isRefreshing = YES;
    self.scrollView.mj_footer.hidden = YES;
    self.currentPage = RefreshPageStart;
    [self refreshData:self.currentPage];
    self.lastRefreshDate = [NSDate date];
}

- (void)footerRefreshing {
    self.currentPage++;
    [self refreshData:self.currentPage];
}

- (void)endRefreshFailure {
    if (self.currentPage > RefreshPageStart) {
        self.currentPage--;
    }
    [self baseEndRefreshing];
    if (self.scrollView.mj_footer.isRefreshing) {
        self.scrollView.mj_footer.state = MJRefreshStateIdle;
    }
}
- (void)baseEndRefreshing {
    if (self.scrollView.mj_header.isRefreshing) {
        [self.scrollView.mj_header endRefreshing];
    }
    self.isRefreshing = NO;
}
- (void)endRefresh:(BOOL)hasMore {
    [self baseEndRefreshing];
    
    if (hasMore) {
        self.scrollView.mj_footer.state = MJRefreshStateIdle;
        ((MJRefreshAutoStateFooter *)self.scrollView.mj_footer).stateLabel.textColor = [UIColor colorWithHex:0x666666];
        self.scrollView.mj_footer.hidden = NO;
    }
    else {
        self.scrollView.mj_footer.state = MJRefreshStateNoMoreData;
        ((MJRefreshAutoStateFooter *)self.scrollView.mj_footer).stateLabel.textColor = [UIColor colorWithHex:0x999999];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollView.mj_footer.hidden = (self.currentPage == RefreshPageStart) || (self.scrollView.contentSize.height < self.scrollView.height);
        });
    }
}
- (void)endRefreshNeedHidden:(BOOL)hasMore {
    [self baseEndRefreshing];
    
    self.scrollView.mj_footer.state = hasMore ? MJRefreshStateIdle : MJRefreshStateNoMoreData;
    self.scrollView.mj_footer.hidden = !hasMore;
}

- (void)refreshData:(NSInteger)page {
    self.currentPage = page;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.scrollView.mj_header.isRefreshing || self.scrollView.mj_footer.isRefreshing) {
            [self endRefreshFailure];
        }
    });
    
}

- (void)setIsRefreshing:(BOOL)isRefreshing {
    _isRefreshing = isRefreshing;
    
    if (self.scrollView.emptyDataSetVisible) {
        [self.scrollView reloadEmptyDataSet];
    }
}

@end
