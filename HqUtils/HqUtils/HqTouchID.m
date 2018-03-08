//
//  HqTouchID.m
//  DaysDemo
//
//  Created by macpro on 16/4/14.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "HqTouchID.h"
//需要导入的头文件
#import <LocalAuthentication/LocalAuthentication.h>
#import <Security/Security.h>

@implementation HqTouchID


#pragma mark - TouchID 验证
+ (void)authenticateByTouchIDWithCompleteBlock:(void(^)(BOOL isSucces,NSString *msg))block
{

    LAContext* context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"输入支付密码";
    //错误对象
    NSError* error = nil;
    NSString* localizedReason = @"需要您的指纹（TouchID）";
    
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError *error) {
            if (success)
            {
                //验证成功，主线程处理UI
                
                [self authenticateResultWithSuccess:YES message:@"验证成功" completeBlock:block];
               
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID
                         [self authenticateResultWithSuccess:NO message:@"系统已取消" completeBlock:block];
                    }
                    break;

                    case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        //用户取消验证Touch ID
                       [self authenticateResultWithSuccess:NO message:@"用户已取消" completeBlock:block];
                    }
                    break;

                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        
                        //用户选择输入密码，切换主线程处理
                        //输入对应账户密码，进行支付
                        [self authenticateResultWithSuccess:NO message:@"您要输入密码" completeBlock:block];
                    }
                    break;

                    default:
                    {
                        //其他情况，切换主线程处理
                        [self authenticateResultWithSuccess:NO message:@"未知错误" completeBlock:block];
                    }
                    break;
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                 [self authenticateResultWithSuccess:NO message:@"未设置TouchID" completeBlock:block];
            }
            break;
            case LAErrorPasscodeNotSet:
            {
               [self authenticateResultWithSuccess:NO message:@"未设置TouchID" completeBlock:block];
            }
             break;
            default:
            {
                NSLog(@"TouchID not available");
                  [self authenticateResultWithSuccess:NO message:@"未设置TouchID" completeBlock:block];
            }
            break;
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}
+ (void)authenticateResultWithSuccess:(BOOL)suc message:(NSString *)msg completeBlock:(void(^)(BOOL isSucces,NSString *msg))block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        block(suc,msg);
    });

}
+ (void)alertWithTitle:(NSString *)title withMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    
}

@end
