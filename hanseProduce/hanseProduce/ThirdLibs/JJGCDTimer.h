//
//  JJGCDTimer.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/29.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class JJGCDTimer;
typedef void(^TimerBlock)(JJGCDTimer*timer);
@interface JJGCDTimer : NSObject
-(instancetype)initWithRepeating:(NSTimeInterval)repeating withBlock:(TimerBlock)block;
@end

NS_ASSUME_NONNULL_END
