//
//  JJGCDTimer.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/28.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JJGCDTimer;
typedef void(^JJGCDTimerBlock)(JJGCDTimer*_Nonnull);
NS_ASSUME_NONNULL_BEGIN

@interface JJGCDTimer : NSObject
-(instancetype)initWithRepeating: (NSTimeInterval)repeat withBlock: (JJGCDTimerBlock)block;

/// 暂停
-(void)suspend;
/// 在n秒后执行
-(void)resumeAfter:(NSTimeInterval)seconds;
/// 取消
-(void)cancel;
@end

NS_ASSUME_NONNULL_END
