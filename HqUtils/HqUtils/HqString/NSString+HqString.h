//
//  NSString+HqString.h
//  DaysDemo
//
//  Created by macpro on 16/4/15.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface NSString (HqString)
#pragma mark - 常用

//判断手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//正则检查匹配
+ (BOOL)checkInputCode:(NSString *)input regex:(NSString *)regex;

//是否包含子字符串
- (BOOL)isContainsString:(NSString *)searchString;

//指定宽度获取文本高度
+ (CGFloat )getTextHeightWithString:(NSString *)string fontSize:(CGFloat )size textWidth:(CGFloat)width;

#pragma mark - 加密
//md5加密
+ (NSString *)md5WithString:(NSString *)str;
+ (NSMutableString *)sha1:(NSString *)input;

#pragma mark - 进制转换
//十六进制字符串转long
+ (unsigned long)hexStrTolong:(NSString *)hexStr;

//data转十六进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data;

//十六进制转字符 GBK编码
+ (NSString *)stringFromHexString:(NSString *)hexString;
//十六进制字符串转换
+ (NSMutableData *)getByteFromStringCommond:(NSString *)commond;

//二进制转十进制
+ (int)toDecimalSystemWithBinarySystem:(NSString *)binary;
//十进制转二进制
+ (NSMutableArray *)toBinarySystemWithDecimalSystem:(int)decimal;

#pragma mark - 获取实例属性值key-value
+ (NSDictionary *)getAllPropertiesInstance:(id)instance;
@end
