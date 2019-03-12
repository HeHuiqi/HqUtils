//
//  HqTimer.m
//  HqUtils
//
//  Created by hqmac on 2019/3/12.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqTimer.h"

@implementation HqTimer
- (void)dealloc{
    
    NSLog(@"HqTimer-dealloc");
}
+ (void)hq_dispatchTimerWithTarget:(id)target
                      timeInterval:(double)timeInterval
                           repeats:(BOOL)repeats
                           handler:(HqTimerhandler)handler{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个timer，这个timer必须时全局变量，不然不会走回调，
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_time(DISPATCH_TIME_NOW, 0),1.0*NSEC_PER_SEC, 0);
    __weak __typeof(target) weaktarget  = target;
    dispatch_source_set_event_handler(timer, ^{
        if (!weaktarget) {
            dispatch_source_cancel(timer);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(timer);
                }
                if (!repeats) {
                    dispatch_source_cancel(timer);
                    return ;
                }
            });
        }
    });
    dispatch_resume(timer);
}

+ (HqTimer *)hq_nsTimerWithTimeInterval:(double)timeInterval
                           repeats:(BOOL)repeats
                           handler:(HqNSTimerhandler)handler{
    HqTimer *ht = [[HqTimer alloc] init];
    ht.hqNSHandler = handler;
    ht.repeats = repeats;
    ht.timer =  [NSTimer scheduledTimerWithTimeInterval:timeInterval target:ht selector:@selector(_invoke:) userInfo:ht repeats:repeats];

    return ht;
}
- (void)destroyNStimer{
    if (self.timer) {
        [self.timer invalidate];
        _timer = nil;
    }
}
- (void)_invoke:(NSTimer *)timer{
    
    HqTimer *hqTimer = timer.userInfo;
    if (self.hqNSHandler) {
        self.hqNSHandler(hqTimer);
    }
    if (!hqTimer.repeats) {
        [hqTimer destroyNStimer];
    }
    
  
}
@end
