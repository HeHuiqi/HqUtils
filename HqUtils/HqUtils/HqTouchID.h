//
//  HqTouchID.h
//  DaysDemo
//
//  Created by macpro on 16/4/14.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HqTouchID : NSObject

#pragma mark - TouchID 验证
+ (void)authenticateByTouchIDWithCompleteBlock:(void(^)(BOOL isSucces,NSString *msg))block;
+ (void)alertWithTitle:(NSString *)title withMessage:(NSString *)message;

@end
