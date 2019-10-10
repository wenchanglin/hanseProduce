//
//  CarouselView.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/28.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "CarouselView.h"
#import <AVKit/AVKit.h>
#import "CALayer+ShowUrl.h"
#import "CenterAlterController.h"
#import "JJGCDTimer.h"
typedef void(^CBlock)(void);

@interface DotLabel : UILabel
@property(nonatomic, assign) NSInteger count;
@property(nonatomic, assign) NSInteger currentIndex;
@end

@implementation DotLabel

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.grayColor;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = UIColor.whiteColor;
        self.font = kRegularFont(11);
        
    }
    return self;
}

-(void)setCount:(NSInteger)count {
    _count = count;
    self.text = [NSString stringWithFormat:@"%ld/%ld", self.currentIndex + 1, self.count];
}

-(void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    self.text = [NSString stringWithFormat:@"%ld/%ld", self.currentIndex + 1, self.count];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.height * 0.5;
    self.clipsToBounds = true;
}
@end


@interface ImgCell : UICollectionViewCell
@property(nonatomic, strong) CALayer *imgView;
@property(nonatomic, strong, nullable) NSString *url;
@end

@implementation ImgCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[CALayer alloc] init];
        self.imgView.contentsGravity = kCAGravityResizeAspectFill;
        self.imgView.masksToBounds = true;
        [self.contentView.layer addSublayer:self.imgView];
    }
    return self;
}

-(void)setUrl:(NSString *)url {
    _url = url;
    [self.imgView showImgUrl:url placeholder:[UIImage imageNamed:@"loading_image3"]];
}

-(void)prepareForReuse {
    [super prepareForReuse];
    self.imgView.contents = nil;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.size = self.contentView.size;
}
@end

@interface MovieCell : UICollectionViewCell
@property(nonatomic, strong) AVPlayerViewController *player;
@property(nonatomic, strong) CALayer *playView;
@property(nonatomic, copy, nullable) CBlock block;
@property(nonatomic, strong, nullable) NSString *url;
@property(nonatomic, assign) BOOL isPlay;
-(void)pause;
-(void)playWithResult: (void(^)(BOOL))result;
@end

@implementation MovieCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.player = [[AVPlayerViewController alloc] init];
        self.player.showsPlaybackControls = false;
        self.player.videoGravity = AVLayerVideoGravityResizeAspect;
        self.player.view.frame = self.bounds;
        self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.player.view];
        self.playView = [[CALayer alloc] init];
        self.playView.contents = kCAGravityResizeAspectFill;
        self.playView.contents = (__bridge id _Nullable)([[UIImage imageNamed:@"play_icon"] CGImage]);
        [self.contentView.layer addSublayer:self.playView];
        UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [self.player.view addGestureRecognizer:t];
        self.isPlay = false;
    }
    return self;
}

-(void)pause {
    self.isPlay = false;
    [self.playView setHidden:false];
    if (self.player.player.rate > 0) {
        [self.player.player pause];
    }
}

-(void)playWithResult:(void (^)(BOOL))result {
    if (!self.player.isReadyForDisplay) {
        result(false);
        return;
    }
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
       [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
           switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                         result(false);
                         break;
                     case AFNetworkReachabilityStatusNotReachable:
                         result(false);
                         break;
                     case AFNetworkReachabilityStatusReachableViaWiFi:
                         result(true);
                         [self reallyPlay];
                         break;
                     case AFNetworkReachabilityStatusReachableViaWWAN: // 4G/或其他
                     {
                         UIViewController *tvc = UIApplication.topViewController;
                         if (!tvc) {
                             result(false);
                             return;
                         }
                         NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"是否使用流量播放该视频" attributes:@{NSFontAttributeName: kRegularFont((14)), NSForegroundColorAttributeName: UIColor.grayColor}];
                         CenterAlterController *vc = [[CenterAlterController alloc] initWithTitle:@"是否使用流量播放该视频" message:attr cancelButtonTitle:@"取消" cancelHandle:^{
                             result(false);
                         } okButtonTitle:@"播放" okHandle:^{
                             [self reallyPlay];
                             result(true);
                         }];
                         [vc showFromSourceController:tvc];
                     }
                         break;
                     default:
                         result(false);
                         break;
           }
           
       }];
}

-(void)reallyPlay {
    if (!self.player.isReadyForDisplay) {
        return;
    }
    [self.player.player play];
    self.isPlay = true;
    [self.playView setHidden:true];
}

-(void)setUrl:(NSString *)url {
    _url = url;
    [self.player.player pause];
    self.player.player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    if (!self.url) {
        return;
    }
    NSURL *U = [NSURL URLWithString:self.url];
    if (!U) {
        return;
    }
    self.player.player = [[AVPlayer alloc] initWithURL:U];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

-(void)playEnd {
    [self.player.player seekToTime:kCMTimeZero];
    self.isPlay = false;
    [self.playView setHidden:false];
    [self.player.player pause];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.playView.size = CGSizeMake(50, 50);
    self.playView.centerX = self.contentView.width * 0.5;
    self.playView.centerY = self.contentView.height * 0.5;
}

-(void)prepareForReuse {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self.player.player pause];
    self.player.player = nil;
    self.isPlay = false;
    [self.playView setHidden:false];
    [super prepareForReuse];
}

-(void)click {
    if (self.block) {
        self.block();
    }
}
@end

@interface CarouselView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) DotLabel *dotLabel;
@property(nonatomic, strong, nullable) JJGCDTimer *timer;
@property(nonatomic, assign) NSTimeInterval timeInterval;
@property(nonatomic, assign) NSInteger totalItems;
@property(nonatomic, strong) NSMutableArray<NSString*> *urls;
@property(nonatomic, strong) NSMutableArray<NSNumber*> *isMovies;
@end

@implementation CarouselView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.timeInterval = 3;
        self.totalItems = 0;
        self.urls = [NSMutableArray array];
        self.isMovies = [NSMutableArray array];
        self.collectionView.frame = self.bounds;
        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.collectionView];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.pageStyle = CarouselViewPageStylePage;
    }
    return self;
}

-(void)reload {
    [self invalidateTimer];
    [self.urls removeAllObjects];
    [self.isMovies removeAllObjects];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceForCarouselView:)]) {
        NSArray *a = [self.delegate dataSourceForCarouselView:self];
        [self.urls addObjectsFromArray:a];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceIsMovieForCarouselView:)]) {
        NSArray *a = [self.delegate dataSourceIsMovieForCarouselView:self];
        [self.isMovies addObjectsFromArray:a];
    } else {
        [self.urls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.isMovies addObject:[NSNumber numberWithBool:false]];
        }];
    }
    if (self.urls.count != self.isMovies.count) {
        [self.collectionView reloadData];
        return;
    }
    NSInteger count = self.urls.count;
    switch (self.pageStyle) {
        case CarouselViewPageStylePage:
            self.pageControl.numberOfPages = count;
            break;
        case CarouselViewPageStyleLabel:
            self.dotLabel.count = count;
            break;
        default:
            break;
    }
    self.totalItems = count * 300;
    [self.collectionView reloadData];
    [self.collectionView setScrollEnabled:count > 1];
    if (count == 0) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(carouselView:didScrollToIndex:)]) {
        [self.delegate carouselView:self didScrollToIndex:0];
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:false];
    if (count == 1) {
        return;
    }
    [self createTimer];
}

-(void)createTimer {
    [self invalidateTimer];
    CGFloat w = self.collectionView.width;
    WEAK
    self.timer = [[JJGCDTimer alloc] initWithRepeating:self.timeInterval withBlock:^(JJGCDTimer * _Nonnull t) {
        dispatch_async(dispatch_get_main_queue(), ^{
            STRONG
            CGFloat offset = self.collectionView.contentOffset.x;
            NSInteger idx = offset / w;
            [self scrollToIndex:(idx + 1) withAnimated:true];
        });
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONG
        if (self.timer != nil) { // 可能连续手动滚动,创建完就销毁
            [self.timer resumeAfter:0];
        }
    });
}

-(void)invalidateTimer {
    if (self.timer) {
        [self.timer cancel];
        self.timer = nil;
    }
}

-(void)scrollToIndex: (NSInteger)idx withAnimated: (BOOL)animated {
    if (idx >= (self.totalItems - self.urls.count)) { // 提前最后一轮转到中间
        idx = self.totalItems * 0.5;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:false];
    } else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:true];
    }
}

-(void)stopPlay {
    NSArray<UICollectionViewCell*> *cells = self.collectionView.visibleCells;
    for (UICollectionViewCell *c in cells) {
        if ([c isKindOfClass:[MovieCell self]]) {
            MovieCell *cell = (MovieCell *)c;
            if (cell.isPlay) {
                [cell pause];
                [self performSelector:@selector(createTimer) withObject:nil afterDelay:0];
            }
        }
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    switch (self.pageStyle) {
        case CarouselViewPageStylePage:
        {
            self.pageControl.width = self.width;
            self.pageControl.height = 30;
            self.pageControl.bottom = self.height;
        }
            break;
        case CarouselViewPageStyleLabel:
        {
            self.dotLabel.width = 32;
            self.dotLabel.height = 16;
            self.dotLabel.bottom = self.height - 17;
            self.dotLabel.right = self.width - 12;
        }
            break;
        default:
            break;
    }
}

-(void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    [self stopPlay];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.totalItems;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    NSString *url = self.urls[idx];
    BOOL isMovie = [self.isMovies[idx] boolValue];
    if (!isMovie) {
        ImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgCell" forIndexPath:indexPath];
        cell.url = url;
        return cell;
    }
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    cell.url = url;
    kWeakSelf(cell);
    WEAK
    cell.block = ^{
        STRONG
        if (weakcell.isPlay) {
            [weakcell pause];
            [self performSelector:@selector(createTimer) withObject:nil afterDelay:0];
        } else {
            [self invalidateTimer];
            [weakcell playWithResult:^(BOOL result) {
                if (!result) {
                    [self performSelector:@selector(createTimer) withObject:nil afterDelay:0];
                }
            }];
        }
    };
    return cell;
}

-(NSInteger)pageControlIndexWithCurrentCellIndex:(NSInteger)idx {
    if (self.urls.count == 0) {
        return 0;
    }
    return idx % self.urls.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) {
        return;
    }
    if ([cell isKindOfClass:[MovieCell self]]) {
        return;
    }
    NSInteger idx = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickImageAtCarouselView:atIndex:)]) {
        [self.delegate didClickImageAtCarouselView:self atIndex:idx];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[ImgCell self]]) {
        return;
    }
    MovieCell *c = (MovieCell *)cell;
    [c pause];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.size;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger idx = (int)roundf(offset / scrollView.width);
    NSInteger pid = [self pageControlIndexWithCurrentCellIndex:idx];
    [self setCurrentPageIndex:pid];
    [self configDelegate];
}

-(void)setCurrentPageIndex: (NSInteger)idx {
    switch (self.pageStyle) {
        case CarouselViewPageStylePage:
            [self.pageControl setCurrentPage:idx];
            break;
        case CarouselViewPageStyleLabel:
            self.dotLabel.currentIndex = idx;
        default:
            break;
    }
}

-(void)configDelegate {
    if (self.urls.count == 0) {
        return;
    }
    NSInteger idx = 0;
    switch (self.pageStyle) {
        case CarouselViewPageStyleLabel:
            idx = self.dotLabel.currentIndex;
            break;
        case CarouselViewPageStylePage:
            idx = self.pageControl.currentPage;
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(carouselView:didScrollToIndex:)]) {
        [self.delegate carouselView:self didScrollToIndex:idx];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self performSelector:@selector(createTimer) withObject:nil afterDelay:0];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self configDelegate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self configDelegate];
}

-(void)setPageStyle:(CarouselViewPageStyle)pageStyle {
    _pageStyle = pageStyle;
    switch (self.pageStyle) {
        case CarouselViewPageStylePage:
            [self.dotLabel removeFromSuperview];
            [self addSubview:self.pageControl];
            break;
        case CarouselViewPageStyleLabel:
            [self.pageControl removeFromSuperview];
            [self addSubview:self.dotLabel];
            break;
        default:
            break;
    }
}

-(void)dealloc {
    self.delegate = nil;
    [self invalidateTimer];
}

-(UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        [_pageControl setHidesForSinglePage:true];
        _pageControl.currentPageIndicatorTintColor = [UIColor.whiteColor colorWithAlphaComponent:0.5];
        _pageControl.currentPageIndicatorTintColor = UIColor.whiteColor;
    }
    return _pageControl;
}

-(DotLabel *)dotLabel {
    if (_dotLabel == nil) {
        _dotLabel = [[DotLabel alloc] initWithFrame:CGRectZero];
    }
    return _dotLabel;
}

-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        fl.minimumLineSpacing = 0;
        fl.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fl];
        _collectionView.pagingEnabled = true;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.bounces = false;
        [_collectionView registerClass:[MovieCell self] forCellWithReuseIdentifier:@"MovieCell"];
        [_collectionView registerClass:[ImgCell self] forCellWithReuseIdentifier:@"ImgCell"];
    }
    return _collectionView;
}

@end
