//
//  HqDecimalNumberUtils.m
//  HqiOS-In-Action
//
//  Created by hqmac on 2018/12/17.
//  Copyright © 2018 HHQ. All rights reserved.
//

#import "HqDecimalNumberUtils.h"

@implementation HqDecimalNumberUtils

//相加
+ (NSString *)addNumber1:(NSString *)num1 nummber2:(NSString *)num2{
    if (num1 && num2) {
        if ([num1 isKindOfClass:NSNumber.class]) {
            NSNumber *nm = (NSNumber *)num1;
            num1 = nm.stringValue;
        }
        if ([num2 isKindOfClass:NSNumber.class]) {
            NSNumber *nm2 = (NSNumber *)num2;
            num2 = nm2.stringValue;
        }
        NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:num1];
        NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:num2];
        NSDecimalNumber *result =  [n1 decimalNumberByAdding:n2];
        return result.stringValue;
    }
    return @"";
}
//相乘
+ (NSString *)multiplyNumber1:(NSString *)num1 nummber2:(NSString *)num2{
    if (num1 && num2) {
        if ([num1 isKindOfClass:NSNumber.class]) {
            NSNumber *nm = (NSNumber *)num1;
            num1 = nm.stringValue;
        }
        if ([num2 isKindOfClass:NSNumber.class]) {
            NSNumber *nm2 = (NSNumber *)num2;
            num2 = nm2.stringValue;
        }
        NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:num1];
        NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:num2];
        NSDecimalNumber *result =  [n1 decimalNumberByMultiplyingBy:n2];
        return result.stringValue;
    }
    return @"";
   
}
//相减
+ (NSString *)subtractNumber1:(NSString *)num1 nummber2:(NSString *)num2{
    if (num1 && num2) {
        if ([num1 isKindOfClass:NSNumber.class]) {
            NSNumber *nm = (NSNumber *)num1;
            num1 = nm.stringValue;
        }
        if ([num2 isKindOfClass:NSNumber.class]) {
            NSNumber *nm2 = (NSNumber *)num2;
            num2 = nm2.stringValue;
        }
        NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:num1];
        NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:num2];
        NSDecimalNumber *result =  [n1 decimalNumberBySubtracting:n2];
        return result.stringValue;
    }
    return @"";
}
//相除
+ (NSString *)dividingNumber1:(NSString *)num1 nummber2:(NSString *)num2{
    if (num1 && num2) {
        if ([num1 isKindOfClass:NSNumber.class]) {
            NSNumber *nm = (NSNumber *)num1;
            num1 = nm.stringValue;
        }
        if ([num2 isKindOfClass:NSNumber.class]) {
            NSNumber *nm2 = (NSNumber *)num2;
            num2 = nm2.stringValue;
        }
        NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:num1];
        NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:num2];
        NSDecimalNumber *result =  [n1 decimalNumberByDividingBy:n2];
        return result.stringValue;
    }
    return @"";
}

+ (NSString *)formatAmountNumber:(NSString *)numberStr{
    return [self formatNumber:numberStr minDigits:0 maxDigits:6];
}
+ (NSString *)formatMoneyNumber:(NSString *)numberStr{
    return [self formatNumber:numberStr minDigits:2 maxDigits:2];
}

+ (NSString *)formatNumber:(NSString *)numberStr minDigits:(int)minDigits  maxDigits:(int)maxDigits{
    
    NSDecimalNumber *roundedOunces = [self _formatNumberStr:numberStr scale:maxDigits];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = maxDigits;
    if (minDigits>0) {
        formatter.minimumFractionDigits = minDigits;
    }
    NSString *string = [formatter stringFromNumber:roundedOunces];
    
    return string;
}
+ (NSDecimalNumber *)_formatNumberStr:(NSString  *)numberStr scale:(int)scale{
    if ([numberStr isKindOfClass:NSNumber.class]) {
        NSNumber *nm = (NSNumber *)numberStr;
        numberStr = nm.stringValue;
    }
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *dm = [NSDecimalNumber decimalNumberWithString:numberStr];
    NSDecimalNumber *result = [dm  decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return result;
}

@end
