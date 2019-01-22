//
//  HqAuthID.m
//  HqUtils
//
//  Created by hqmac on 2019/1/7.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqAuthID.h"

#import <UIKit/UIKit.h>

@implementation HqAuthID

+ (instancetype)sharedInstance {
    static HqAuthID *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HqAuthID alloc] init];
    });
    return instance;
}

- (void)yz_showAuthIDWithDescribe:(NSString *)describe block:(YZAuthIDStateBlock)block {
    if(describe.length==0) {
        if(iPhoneX){
            describe = @"验证已有面容";
        }else{
            describe = @"通过Home键验证已有指纹";
        }
    }
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"系统版本不支持TouchID/FaceID (必须高于iOS 8.0才能使用)");
            block(YZAuthIDStateVersionNotSupport, NSError.new);
        });
        
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    // 认证失败提示信息，为 @"" 则不提示
    context.localizedFallbackTitle = @"输入密码";
    NSError *error = nil;
    // LAPolicyDeviceOwnerAuthenticationWithBiometrics: 用TouchID/FaceID验证
    // LAPolicyDeviceOwnerAuthentication: 用TouchID/FaceID或密码验证, 默认是错误两次或锁定后, 弹出输入密码界面（本案例使用）
    LAPolicy policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
//    if (@available(iOS 9.0, *)) {
//        policy = LAPolicyDeviceOwnerAuthentication;
//    }
    if ([context canEvaluatePolicy:policy error:&error]){
        [context evaluatePolicy:policy localizedReason:describe reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //NSLog(@"TouchID/FaceID 验证成功");
                    block(YZAuthIDStateSuccess, error);
                });
            }else if(error){
                if (@available(iOS 11.0, *)) {
                    [self dealAuthWithError:error block:block];
                } else {
                    [self dealAuthWithError:error block:block];
                }
            }
        }];
    }else{
        [self dealAuthWithError:error block:block];
    }
}
- (void)dealAuthWithError:(NSError *)error block:(YZAuthIDStateBlock)block{
    // iOS 11.0以下的版本只有 TouchID 认证
    switch (error.code) {
        case LAErrorAuthenticationFailed:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 验证失败");
                block(YZAuthIDStateFail, error);
            });
            break;
        }
        case LAErrorUserCancel:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 被用户手动取消");
                block(YZAuthIDStateUserCancel, error);
            });
        }
            break;
        case LAErrorUserFallback:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"用户不使用TouchID,选择手动输入密码");
                block(YZAuthIDStateInputPassword, error);
            });
        }
            break;
        case LAErrorSystemCancel:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                block(YZAuthIDStateSystemCancel, error);
            });
        }
            break;
        case LAErrorPasscodeNotSet:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 无法启动,因为用户没有设置密码");
                block(YZAuthIDStatePasswordNotSet, error);
            });
        }
            break;
        case LAErrorTouchIDNotEnrolled:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 无法启动,因为用户没有设置TouchID");
                block(YZAuthIDStateTouchIDNotSet, error);
            });
        }
            break;
            //case :{
        case LAErrorTouchIDNotAvailable:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 无效");
                block(YZAuthIDStateTouchIDNotAvailable, error);
            });
        }
            break;
        case LAErrorTouchIDLockout:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                block(YZAuthIDStateTouchIDLockout, error);
            });
        }
            break;
        case LAErrorAppCancel:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                block(YZAuthIDStateAppCancel, error);
            });
        }
            break;
        case LAErrorInvalidContext:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                block(YZAuthIDStateInvalidContext, error);
            });
        }
            break;
        default:
            break;
    }
}
@end
