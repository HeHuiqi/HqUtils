//
//  HqEncrypt.h
//  DaysDemo
//
//  Created by macpro on 16/4/22.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqEncrypt : NSObject

#pragma mark - 文本数据进行DES加密
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;

#pragma mark - 文本数据进行DES解密
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;

#pragma mark - DES加密后返回 NSdata
+ (NSData *)DESEncryptWithString:(NSString *)str key:(NSString *)key;

#pragma mark - DES解密后返回 NSString
+ (NSString *)StirngDESDecrypt:(NSData *)data WithKey:(NSString *)key;

#pragma mark - SHA1加密
- (NSString *)sha1WithData:(NSData *)data;

#pragma mark - MD5加密
+ (NSString *)md5WithString:(NSString *)str;

@end
