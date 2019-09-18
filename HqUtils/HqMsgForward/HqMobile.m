//
//  HqMobile.m
//  HqUtils
//
//  Created by hehuiqi on 8/7/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqMobile.h"
#import "HqiPhone.h"

@implementation HqMobile

// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100

//C方式
void addCall(id self,SEL _cmd ,NSString  *number){
    NSLog(@"添加一个Call方法:%@",number);
}
//OC方式
- (void)addCall:(NSString *)number{
    NSLog(@"添加一个Call2方法:%@",number);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"sel-1 == %@",NSStringFromSelector(sel));
//    Method method = class_getInstanceMethod(self, sel);
//   const char *types = method_getTypeEncoding(method);
    
    // v=void @=self :=SEL arguments....types *=字符串
    //这里找不到对应的SEL后给当前类动态添加了一个addCall方法，如果不添加就进入forwardingTargetForSelector:转发
    //OC添加的方法获取一下IMP
    //IMP addIMP = (IMP)class_getMethodImplementation(self, @selector(addCall:));
    /*
    IMP addIMP = (IMP)addCall;
    BOOL isAddSuc =   class_addMethod(self, sel, addIMP,"v@:*");
    if (isAddSuc) {
        return YES;
    }
    */
    return [super resolveInstanceMethod:sel];
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"aSelector-2 == %@",NSStringFromSelector(aSelector));
    //这里将HqMobile不能处理的消息转发给了HqiPhone对象
    
    /*
    HqiPhone *iphone = [HqiPhone new];
    if ([iphone respondsToSelector:aSelector]) {
        return iphone;
    }
    */
    return [super forwardingTargetForSelector:aSelector];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"aSelector-3 == %@",NSStringFromSelector(aSelector));
    NSString *sel = NSStringFromSelector(aSelector);
    //这里方法签名要和aSelector的签名一致，转发给目标对象有一个同样的aSelector
    //这力签名返回后会走forwardInvocation:进入转发调用设置NSInvocation的target
    NSMethodSignature *sig =  [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    if ([sel isEqualToString:@"call:"]) {
        return sig;
    }

    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"aSelector-3 == %@",NSStringFromSelector(anInvocation.selector));
    
    
    //如果这里转发的目标，没有对应的anInvocation.selector，那么就会走doesNotRecognizeSelector
    HqiPhone *iphone = [HqiPhone new];
    if ([iphone respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:iphone];
        return;
    }
    [super forwardInvocation:anInvocation];
}
- (void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"aSelector-4 == %@",NSStringFromSelector(aSelector));
    [super doesNotRecognizeSelector:aSelector];
}


@end
