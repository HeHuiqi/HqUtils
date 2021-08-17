//
//  HqUncaughtExceptionHandler.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/12.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//监听Crash报告信息
extern NSString * const HqUncaughtExceptionReportNofity;

@interface HqUncaughtExceptionHandler : NSObject

// showException: 是否向用户提示
// - (BOOL)application:didFinishLaunchingWithOptions: 调用此方法
+ (void)startCatchCrashWithShowException:(BOOL)showException;


@end



NS_ASSUME_NONNULL_END

