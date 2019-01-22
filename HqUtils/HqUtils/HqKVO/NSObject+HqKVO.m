//
//  NSObject+HqKVO.m
//  HqiOS-In-Action
//
//  Created by hqmac on 2019/1/22.
//  Copyright © 2019 HHQ. All rights reserved.
//

#import "NSObject+HqKVO.h"
#import <objc/message.h>

@implementation NSObject (HqKVO)

- (void)Hq_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    //1创建一个子类
    NSString *oldClassName = NSStringFromClass(self.class);
    NSString *newClassName = [@"HQKVO_" stringByAppendingString:oldClassName];
    
    Class newSubClass = objc_allocateClassPair(self.class, newClassName.UTF8String, 0);
    //注册类
    objc_registerClassPair(newSubClass);
    
    //2重写set方法
    //这里指重写了User类的setName作为一个简单实现
    class_addMethod(newSubClass, @selector(setName:), (IMP)setName, "v@:@");
    
    //修改isa指针，指向子类
    object_setClass(self, newSubClass);
    
    
    //将观察者保存到当前对象
    //OBJC_ASSOCIATION_ASSIGN这里用这个事为了防止循环引用
    objc_setAssociatedObject(self, "observer", observer, OBJC_ASSOCIATION_ASSIGN);
}
//之类要把隐藏参数写出来
/*
 OBJC_EXPORT id _Nullable
 objc_msgSend(id _Nullable self, SEL _Nonnull op, ...)
 */
void setName(id self,SEL _cmd, NSString *newName){
    NSLog(@"重写set方法了");
    //先调用父类的方法
    Class subClass = [self class];
    Class superClass = class_getSuperclass(subClass);
    //改变当前isa执行superClass
    object_setClass(self, superClass);

    //调用父类的set方法,
    //这里要Build Settings要修改一下 （Enable Strict checking of objc_msgSend Calls）为NO,搜索msg即可
    //不然会报编译错误
    objc_msgSend(self,@selector(setName:),newName);

    //获取观察者
    id observer = objc_getAssociatedObject(self, "observer");
    //通知观察者
    if (observer) {
        objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),@"name",self,@{@"new":newName,@"kind":@1},nil);
    }

    //让isa指针重新指向子类
    object_setClass(self, subClass);
}
@end
