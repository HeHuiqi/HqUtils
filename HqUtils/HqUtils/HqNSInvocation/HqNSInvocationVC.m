//
//  HqNSInvocationVC.m
//  HqUtils
//
//  Created by hqmac on 2019/3/9.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqNSInvocationVC.h"
#import <objc/message.h>
@implementation HqNSInvocationVC

//id objc_msgSend(id self,SEL op,...);
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //普通调用
//    int result = [self addA:1 andB:2];
//    NSLog(@"result == %@",@(result));
    
     // 严格模式下 objc_msgSend的原型是无返回值为参数的C方法
     //  void objc_msgSend(void /* id self, SEL op, ... */ )
    
    /*
     #import <objc/message.h>
     要想调用有返回值有参数的方法，需要对编译器进行设置
     1.注意这里编译器的设置
     TARGETS->Build Settings->搜索msg，设置为NO
     2.定义要调用方法的原型，重定义objc_msgSend方法的原型
     不定义远行获取返回值将发生崩溃
     3.用定义后原型的方法名在调用方法，注意参数的类型和个数
    */
    // 这里要调用的方法有返回值，并且有两个int类型的参数，所有原型定义如下：
    int (*objc_action_send)(id, SEL, int,int) = (int (*)(id, SEL, int,int)) objc_msgSend;
    //用定义的原型名字调用方法并传入对应的参数
    int res = objc_action_send(self,@selector(addA:andB:),1,2);
    NSLog(@"res == %@",@(res));

    
//    [self invocation];
//    [self invocation2];
//    [self invocation3];

    
    
}

- (void)invocation{
    //根据方法创建签名对象sig
    NSMethodSignature *sign = [self.class instanceMethodSignatureForSelector:@selector(method)];
    // 根据签名对象创建调用对象invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sign];
    //设置target
    invocation.target = self;
    //设置selector
    invocation.selector = @selector(method);
    //消息调用
    [invocation invoke];
}
- (void)method {
    NSLog(@"method被调用");
}

- (void)invocation2{
    //根据方法创建签名对象sig
    NSMethodSignature *sign = [self.class instanceMethodSignatureForSelector:@selector(sumNumber1:number2:)];
    //根据签名创建invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sign];
    //设置调用对象相关信息
    invocation.target = self;
    invocation.selector = @selector(sumNumber1:number2:);
    NSInteger number1 = 30;
    NSInteger number2 = 10;
    [invocation setArgument:&number1 atIndex:2];
    [invocation setArgument:&number2 atIndex:3];
    //消息调用
    [invocation invoke];
    
    //获取返回值
    NSNumber *sum = nil;
    [invocation getReturnValue:&sum];
    
    NSLog(@"总和==%zd",[sum integerValue]);
}
- (NSNumber*)sumNumber1:(NSInteger)number1 number2:(NSInteger)number2{
    NSInteger sum = number1+number2;
    return @(sum);
}

- (void)invocation3{
    // methodSignatureForSelector 如何调用者时Class则返回该类的类方法签名，
    //如果是一个实例对象，则返回该类的实例方法签名
    NSMethodSignature *msig = [self methodSignatureForSelector:@selector(addA:andB:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:msig];
    invocation.selector = @selector(addA:andB:);
    invocation.target = self;
    int a = 1;
    int b = 2;
    
    
    [invocation setArgument:&a  atIndex:2];
    [invocation setArgument:&b atIndex:3];
    [invocation invoke];
    
    
    int inResult = 0;
    [invocation getReturnValue:&inResult];
    NSLog(@"invation == %@",@(inResult));
}

- (int)addA:(int)A andB:(int)B{
    NSLog(@"A,B=%d,%d",A,B);
    return A+B;
}

@end
