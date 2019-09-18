//
//  HqInvokeManager.m
//  HqTestdYSM
//
//  Created by hehuiqi on 6/12/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import "HqInvokeManager.h"

@interface HqInvokeManager  ()

@end


@implementation HqInvokeManager
- (void)dealloc{
    [self removerObserver];
}
- (instancetype)init{
    if (self = [super init]) {
        self.methodParams = [NSMutableDictionary dictionaryWithCapacity:0];
        self.methods = [NSMutableArray arrayWithCapacity:0];
        [self addObserver];
        
    }
    return self;
}
- (void)removerObserver{
    [self removeObserver:self forKeyPath:@"flag"];
}
- (void)addObserver{
    [self addObserver:self forKeyPath:@"flag" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
}

- (void)invokeInstance:(NSObject *)instance asyncMethod:(SEL)method{
    NSString *methodStr = NSStringFromSelector(method);
    [self.methods addObject:methodStr];
    if (self.methods.count == 1) {
        self.instance  = instance;
    }
}
- (void)invokeInstance:(NSObject *)instance asyncMethods:(NSArray<NSString *> *)methods{
    if (methods.count>0) {
        for (NSString *methodStr in methods) {
            [self.methods addObject:methodStr];
        }
        self.instance = instance;
        [self start];
    }
}
- (void)start{
    if (self.methods.count>0) {
        self.flag = 0;
    }
}
- (void)stop{
    if (self.methods.count>0) {
        [self.methods removeObjectAtIndex:0];
    }
    self.flag = 0;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (self.flag == 0) {
        
        NSString *methodStr = self.methods.firstObject;
        if (methodStr.length>0) {
            SEL method = NSSelectorFromString(methodStr);
            NSLog(@"method == %@",methodStr);
            [self instanceInvokeSelector:method];
            
            self.flag = 1;
        }
    }
    
}
- (void)instanceInvokeSelector:(SEL)selector{
    //根据方法创建签名对象sig
    NSMethodSignature *sign = [self.instance.class instanceMethodSignatureForSelector:selector];
    // 根据签名对象创建调用对象invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sign];
    //设置target
    invocation.target = self.instance;
    //设置selector
    invocation.selector = selector;
    //消息调用
    [invocation invoke];
}


- (void)invocationWithSelector:(SEL)selector{
    //根据方法创建签名对象sig
    NSMethodSignature *sign = [self.class instanceMethodSignatureForSelector:selector];
    // 根据签名对象创建调用对象invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sign];
    //设置target
    invocation.target = self;
    //设置selector
    invocation.selector = selector;
    //消息调用
    [invocation invoke];
}



@end
