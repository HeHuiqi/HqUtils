//
//  HqEncrypt.m
//  DaysDemo
//
//  Created by macpro on 16/4/22.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "HqEncrypt.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation HqEncrypt

#pragma mark - 文本数据进行DES加密
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //返回base64编码
        return [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];;
    }
    
    free(buffer);
    return nil;
}
#pragma mark - 文本数据进行DES解密
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/

+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

#pragma mark - DES加密后返回 NSdata
+ (NSData *)DESEncryptWithString:(NSString *)str key:(NSString *)key
{
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [self  DESEncrypt:strData WithKey:key];
}

#pragma mark - DES解密后返回 NSString
+ (NSString *)StirngDESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    NSData *decryptData = [self DESDecrypt:data WithKey:key];
    
    NSString *dataStr = [[NSString alloc]initWithData:decryptData encoding:NSUTF8StringEncoding];
    return dataStr;
}



#pragma mark - SHA1加密
- (NSString *)sha1WithData:(NSData *)data
{
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

#pragma mark - MD5加密
+ (NSString *)md5WithString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}
#pragma mark - AES256加密
+ (NSData *)AES256EncryptWithKey:(NSString *)key iv:(NSString *)iv encryptText:(NSString *)text{
    
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t bufferSize = data.length + kCCKeySizeAES256;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置加密参数
    /**
    这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
     */
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES,kCCOptionPKCS7Padding,
                                          key.UTF8String, kCCKeySizeAES256,
                                          iv.UTF8String,
                                          data.bytes, data.length,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    }
    
    free(buffer);
    
    return nil;
}
// 十六进制字符串转换
+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}
#pragma mark - AES256解密
+ (NSData *)AES256DecryptWithKey:(NSString *)key iv:(NSString *)iv decryptHexText:(NSString *)hexText{

    NSData *data = [self convertHexStrToData:hexText];
    size_t bufferSize = data.length + kCCKeySizeAES256;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置解密参数
    /**
     这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
     */
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES,kCCOptionPKCS7Padding,
                                          key.UTF8String, kCCKeySizeAES256,
                                          iv.UTF8String,
                                          data.bytes, data.length,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    }
    
    free(buffer);
    
    return nil;
    
}
@end
