//
//  HqUncaughtExceptionHandler.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/12.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqUncaughtExceptionHandler.h"



#import <UIKit/UIKit.h>
//#include <libkern/OSAtomic.h>
#import <execinfo.h>
#import <stdatomic.h>

NSString * const HqUncaughtExceptionReportNofity = @"HqUncaughtExceptionReportNofity";

NSString * const HqUncaughtExceptionHandlerSignalExceptionName = @"HqUncaughtExceptionHandlerSignalExceptionName";
NSString * const HqUncaughtExceptionHandlerSignalKey = @"HqUncaughtExceptionHandlerSignalKey";
NSString * const HqUncaughtExceptionHandlerAddressesKey = @"HqUncaughtExceptionHandlerAddressesKey";

atomic_int HqExceptionCount = 0;
const int32_t HqExceptionMaximum = 10;

static BOOL HqShowException = NO;
static NSString *msg = nil;

const NSInteger HqUncaughtExceptionHandlerReportAddressCount = 10;//指明报告多少条调用堆栈信息

//处理未捕获的异常
void HandleUncaughtException(NSException *exception);
//处理信号类型的异常
void HandleSignal(int signal);
//为两种类型的信号注册处理函数
void InstallUncaughtExceptionHandler(void);


@interface HqUncaughtExceptionHandler ()

//获取堆栈指针，返回符号化之后的数组
+ (NSArray *)backtrace;

//处理异常2，包括抛出的异常和信号异常
- (void)handleException:(NSException *)exception;

@end

@implementation HqUncaughtExceptionHandler

- (instancetype)init{
    if (self = [super init]) {

    }
    return  self;
}

+ (NSArray *)backtrace{
    void *callStack[128];//堆栈方法数组
    int frames = backtrace(callStack, 128);//从iOS的方法backtrace中获取错误堆栈方法指针数组，返回数目
    char **strs = backtrace_symbols(callStack, frames);//符号化
    
    NSMutableArray *symbolsBackTrace=[NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i<HqUncaughtExceptionHandlerReportAddressCount; i++) {
        [symbolsBackTrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return symbolsBackTrace;
}
- (NSString *)getTemporaryDirectory
{
    NSString *tmp = NSTemporaryDirectory();
    return tmp;
}
- (void)saveCrash:(NSString *)crash{
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy_MM_dd_HH_mm_ss"];
    NSString *fileName = [NSString stringWithFormat:@"%@_crash",[df stringFromDate:now]];
    NSString *savePath = [[self getTemporaryDirectory] stringByAppendingPathComponent:fileName];
    [crash writeToFile:savePath atomically:YES encoding:(NSUTF8StringEncoding) error:nil];
    
}
- (void)handleException:(NSException *)exception{
    NSMutableString *callStackSymbolsStr = [[NSMutableString alloc] init];
    NSArray *callStackSymbols = exception.callStackSymbols;
    if (callStackSymbols.count ==  0) {
        callStackSymbols = [exception.userInfo objectForKey:HqUncaughtExceptionHandlerAddressesKey];
    }
    for (NSString *stack_symbol in callStackSymbols) {
        [callStackSymbolsStr appendFormat:@"%@\n",stack_symbol];
    }
    
    NSString *message = [NSString stringWithFormat:@"异常名称：%@\n异常原因：%@\n详情：\n%@",exception.name,exception.reason,callStackSymbolsStr];
    [[NSNotificationCenter defaultCenter] postNotificationName:HqUncaughtExceptionReportNofity object:message];
    [self saveCrash:message];
    
//    NSLog(@"name:%@",exception.name);
//    NSLog(@"reason:%@",exception.reason);
//    NSLog(@"userInfo:%@",exception.userInfo);
//    NSLog(@"callStackSymbols:%@",exception.callStackSymbols);
//    NSLog(@"callStackReturnAddresses:%@",exception.callStackReturnAddresses);
    NSLog(@"");
    if (!HqShowException) {
        [self killApp:exception];
        return;
        
    }
    //是否退出App
    __block BOOL quitApp = NO;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"出现异常了" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"退出" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        quitApp = YES;
    }];
    [alert addAction:quit];
    /*
    UIAlertAction *quitApp = [UIAlertAction actionWithTitle:@"继续" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        quitApp = NO;
    }];
     [alert addAction:quitApp];
    */
    
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootVC presentViewController:alert animated:YES completion:nil];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    NSArray *arr = (__bridge NSArray *)allModes;
    
    //如果不退出App就继续运行Runloop，while后边的代码不会执行
    while (!quitApp) {
        for (NSString *mode in arr) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    CFRelease(allModes);
    [self killApp:exception];
 
}

- (void)killApp:(NSException *)exception{
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:HqUncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:HqUncaughtExceptionHandlerSignalKey] intValue]);
    }
    else
    {
        [exception raise];
    }
}

+ (void)startCatchCrashWithShowException:(BOOL)showException{
    HqShowException = showException;
    InstallUncaughtExceptionHandler();
}



@end

//处理未捕获的异常
void HandleUncaughtException(NSException *exception){
    
    //异常处理在子线程，要回到主线程才能展示UI
    HqUncaughtExceptionHandler *uncaughtExceptionHandler=[[HqUncaughtExceptionHandler alloc] init];
    [uncaughtExceptionHandler performSelector:@selector(handleException:) onThread:[NSThread mainThread] withObject:exception waitUntilDone:YES];

}

//处理信号类型的异常
void HandleSignal(int signal){
    //    int32_t HqExceptionCount= OSAtomicIncrement32(&HqExceptionCount);
    atomic_fetch_add_explicit(&HqExceptionCount, 1, memory_order_relaxed); // atomic
    
    if (HqExceptionCount>HqExceptionMaximum) {
        return;
    }
    
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:HqUncaughtExceptionHandlerSignalKey];
    NSArray *callBack=[HqUncaughtExceptionHandler backtrace];
    [userInfo setObject:callBack forKey:HqUncaughtExceptionHandlerAddressesKey];
    
    NSException *signalException=[NSException exceptionWithName:HqUncaughtExceptionHandlerSignalExceptionName reason:[NSString stringWithFormat:@"Signal %d was raised.",signal] userInfo:userInfo];
    
    HqUncaughtExceptionHandler *uncaughtExceptionHandler = [[HqUncaughtExceptionHandler alloc] init];
    [uncaughtExceptionHandler performSelector:@selector(handleException:) onThread:[NSThread mainThread] withObject:signalException waitUntilDone:YES];
    
}

void InstallUncaughtExceptionHandler(void){
    NSSetUncaughtExceptionHandler(HandleUncaughtException);//设置未捕获的异常处理
    
    //设置信号类型的异常处理
    signal(SIGABRT, HandleSignal);
    signal(SIGILL, HandleSignal);
    signal(SIGSEGV, HandleSignal);
    signal(SIGFPE, HandleSignal);
    signal(SIGBUS, HandleSignal);
    signal(SIGPIPE, HandleSignal);
}

