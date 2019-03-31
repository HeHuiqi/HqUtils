//
//  HqDecimalNumberUtils.h
//  HqiOS-In-Action
//
//  Created by hqmac on 2018/12/17.
//  Copyright © 2018 HHQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqDecimalNumberUtils : NSObject

//相加
+ (NSString *)addNumber1:(NSString *)num1 nummber2:(NSString *)num2;
//相减
+ (NSString *)subtractNumber1:(NSString *)num1 nummber2:(NSString *)num2;
//相乘
+ (NSString *)multiplyNumber1:(NSString *)num1 nummber2:(NSString *)num2;
//相除
+ (NSString *)dividingNumber1:(NSString *)num1 nummber2:(NSString *)num2;
//保留两位,最少2位
+ (NSString *)formatAmountNumber:(NSString *)numberStr;
//保留6位
+ (NSString *)formatMoneyNumber:(NSString *)numberStr;
//自定义
+ (NSString *)formatNumber:(NSString *)numberStr minDigits:(int)minDigits  maxDigits:(int)maxDigits;

@end

NS_ASSUME_NONNULL_END
