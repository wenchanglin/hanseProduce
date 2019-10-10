//
//  JJGCDTimer.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/28.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "JJGCDTimer.h"

typedef NS_CLOSED_ENUM(NSInteger, JJGCDTimerState){
    JJGCDTimerStateSuspended,
    JJGCDTimerStateResumed,
};

@interface JJGCDTimer ()
@property(nonatomic, assign) NSTimeInterval repeat;
@property(nonatomic, assign) JJGCDTimerState state;
@property(nonatomic, copy, nullable) JJGCDTimerBlock block;
@property(nonatomic, strong, nullable) dispatch_source_t timer;
@end

@implementation JJGCDTimer

-(instancetype)initWithRepeating: (NSTimeInterval)repeat withBlock: (JJGCDTimerBlock)block {
    self = [super init];
    if (self) {
        self.repeat = repeat;
        if (block) {
            self.block = block;
        }
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.repeat * NSEC_PER_SEC)), repeat * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(self.timer, ^{
            if (self.block) {
                self.block(self);
            }
        });
        self.state = JJGCDTimerStateSuspended;
    }
    return self;
}


-(void)suspend {
    if (!self.timer) {
        return;
    }
    if (self.state == JJGCDTimerStateSuspended) {
        return;
    }
    dispatch_suspend(self.timer);
    self.state = JJGCDTimerStateResumed;
}

-(void)resumeAfter:(NSTimeInterval)seconds {
    if (!self.timer) {
        return;
    }
    if (self.state == JJGCDTimerStateResumed) {
        return;
    }
    if (seconds == 0) {
        if ([NSThread isMainThread]) {
            if (self.block) {
                self.block(self);
            }
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.block) {
                self.block(self);
            }
        });
        return;
    }
    WEAK
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONG
        if (self.timer == nil) {
            return;
        }
        if (self.state == JJGCDTimerStateResumed) {
            return;
        }
        dispatch_resume(self.timer);
        self.state = JJGCDTimerStateResumed;
    });
}

-(void)cancel {
    if (!self.timer) {
        return;
    }
    if (self.state == JJGCDTimerStateSuspended) {
        dispatch_source_set_event_handler(self.timer, nil);
        dispatch_resume(self.timer);
    }
    dispatch_source_cancel(self.timer);
    self.state = JJGCDTimerStateSuspended;
    self.timer = nil;
}

-(void)dealloc {
    [self cancel];
}

@end
