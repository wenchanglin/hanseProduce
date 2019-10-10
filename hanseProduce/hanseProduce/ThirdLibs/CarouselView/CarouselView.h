//
//  CarouselView.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/28.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_CLOSED_ENUM(NSInteger, CarouselViewPageStyle) {
    CarouselViewPageStylePage,
    CarouselViewPageStyleLabel,
};

@class CarouselView;
@protocol CarouselDelegate <NSObject>
@optional
-(NSArray<NSString*>*_Nonnull)dataSourceForCarouselView:(nonnull CarouselView*)carouselView;
-(NSArray<NSNumber*>*_Nonnull)dataSourceIsMovieForCarouselView:(nonnull CarouselView*)carouselView;
-(void)didClickImageAtCarouselView:(nonnull CarouselView*)carouselView atIndex:(NSInteger)idx;
-(void)carouselView:(nonnull CarouselView*)carouselView didScrollToIndex: (NSInteger)idx;
@end
NS_ASSUME_NONNULL_BEGIN

/// 轮播图view
@interface CarouselView : UIView
@property(nonatomic, weak, nullable) id<CarouselDelegate>delegate;
@property(nonatomic, assign) CarouselViewPageStyle pageStyle;
-(void)reload;
-(void)stopPlay;
@end

NS_ASSUME_NONNULL_END
