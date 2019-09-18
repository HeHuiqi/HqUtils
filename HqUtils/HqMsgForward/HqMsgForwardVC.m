//
//  HqMsgForwardVC.m
//  HqUtils
//
//  Created by hehuiqi on 8/7/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqMsgForwardVC.h"
#import "HqMobile.h"
typedef void (* _IMP) (id,SEL,...);
@interface HqMsgForwardVC ()

@end

@implementation HqMsgForwardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testMsgForward];
    UIViewController *vc;
}

- (void)testIMP{
    _IMP myIMP;
    //    Method method =  class_getInstanceMethod(self.class, @selector(myName));
    //    myIMP = (_IMP)method_getImplementation(method);
    //    myIMP = (_IMP)class_getMethodImplementation(self.class, @selector(myName:));
    myIMP = (_IMP)[self.class instanceMethodForSelector:@selector(myName:)];
    myIMP(self,@selector(myName:),@"呵呵呵");
    __builtin_return_address(0);
}
- (BOOL)myName:(NSString *)name{
    NSLog(@"IMP调用我的名字了:%@",name);
    return YES;
}

- (void)testMsgForward{
    HqMobile *moblie = [HqMobile new];
    [moblie call:@"12345678"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
