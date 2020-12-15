//
//  HqTimer.h
//  HqUtils
//
//  Created by hqmac on 2019/3/12.
//  Copyright © 2019 macpro. All rights reserved.
//
//使用见HqTestVC.h
#import <Foundation/Foundation.h>
@class HqTimer;
typedef void (^HqTimerhandler)(dispatch_source_t _Nullable timer);
typedef void (^HqNSTimerhandler)(HqTimer * _Nonnull hqTimer);


NS_ASSUME_NONNULL_BEGIN


@interface HqTimer : NSObject



@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL repeats;

@property (nonatomic,copy) HqNSTimerhandler hqNSHandler;
- (void)destroyNStimer;


@property (nonatomic,strong) dispatch_source_t dispatchTimer;

//使用这个方法，然后在UIController的delloc方法调用destroyDispatchTimer方法
+ (HqTimer *)hq_dispatchTimerWithTarget:(id)target
                      timeInterval:(double)timeInterval
                           repeats:(BOOL)repeats
                           handler:(HqTimerhandler)handler;
- (void)destroyDispatchTimer;

//使用这个方法，需要声明全HqTimer局变量，然后在UIController的delloc方法调用destroyNStimer方法即可
+ (HqTimer *)hq_nsTimerWithTimeInterval:(double)timeInterval
                                repeats:(BOOL)repeats
                                handler:(HqNSTimerhandler)handler;


@end

NS_ASSUME_NONNULL_END
