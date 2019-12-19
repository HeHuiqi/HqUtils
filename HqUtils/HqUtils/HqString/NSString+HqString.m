//
//  NSString+HqString.m
//  DaysDemo
//
//  Created by macpro on 16/4/15.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "NSString+HqString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (HqString)

#pragma mark - 常用

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSRegularExpression * regular = [[NSRegularExpression alloc]initWithPattern:phoneRegex options:NSRegularExpressionCaseInsensitive error:nil];
    return [regular numberOfMatchesInString:mobileNum options:NSMatchingReportCompletion range:NSMakeRange(0, mobileNum.length)];
}
//正则检查匹配
+ (BOOL)checkInputCode:(NSString *)input regex:(NSString *)regex
{
    NSRegularExpression * regular = [[NSRegularExpression alloc]initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    return [regular numberOfMatchesInString:input options:NSMatchingReportCompletion range:NSMakeRange(0, input.length)];
}
//是否包含子字符串
- (BOOL)isContainsString:(NSString *)searchString{
    
    if (strstr([self UTF8String], [searchString UTF8String])) {
        return YES;
    }
    
    return NO;
}
//指定宽度获取文本高度
+ (CGFloat )getTextHeightWithString:(NSString *)string fontSize:(CGFloat )size textWidth:(CGFloat)width
{
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil].size;
    return contentSize.height;
}
#pragma mark - 加密
//md5加密
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
//sha1
+ (NSMutableString *)sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
#pragma mark - 进制转换
// 十六进制字符串转long
+ (unsigned long)hexStrTolong:(NSString *)hexStr{
    char *rest = (char *)[hexStr UTF8String];
    unsigned long sum = 0;
    for (int i = 0; i<hexStr.length; i++) {
        char j[1] = {rest[i]};
        unsigned long k =  strtoul(j,0,16);
        sum = sum + k*powf(16, hexStr.length - i - 1);
    }
    return sum;
}
//data转十六进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

// 十六进制转字符 GBK编码
+ (NSString *)stringFromHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:encode];
    return unicodeString;
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
// 二进制转十进制
+ (int)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    return ll;
}
// 十进制转二进制
+ (NSMutableArray *)toBinarySystemWithDecimalSystem:(int)decimal
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    if (decimal == 0) {
        return nil;
    }
    int num = decimal;
    int remainder = 0;      //余数
    int divisor = 0;        //除数
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",remainder];
        [resultArray addObject:[NSNumber numberWithInt:remainder]];
        if (divisor == 0)
        {
            break;
        }
    }
    return resultArray;
}

#pragma mark - 获取实例属性值key-value
+ (NSDictionary *)getAllPropertiesInstance:(id)instance{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    //属性的链表
    objc_property_t *properties =class_copyPropertyList([instance class], &outCount);
    //遍历链表
    for (int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        //获取属性字符串
        const char* propertyName =property_getName(property);
        //转换成NSString
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //获取属性对应的value
        id value = [instance valueForKey:key];
        
        [props setObject:value forKey:key];
    }
    //释放结构体数组内存
    free(properties);
    return props;
}

//时分秒
+ (NSString *)formatSeconds:(NSInteger)seconds{
    
    NSString *result = @"00:00:00";
    
    if (seconds>0) {
        NSInteger minute = seconds/60;
        NSInteger second = seconds%60;
        result = [NSString stringWithFormat:@"00:%02ld:%02ld",minute,second];
    }
    
    return result;
}
#pragma mark 格式化url查询参数
+ (NSDictionary *)queryParamsFormatUrlString:(NSString *)urlStr{
    NSRange questionRange = [urlStr rangeOfString:@"?"];
    if (questionRange.length == 0) {
        return nil;
    }
    
    NSString *query = [urlStr substringFromIndex:questionRange.location+1];
    if (query.length>0) {
        query = [query stringByAppendingString:@"&end=placeholder"];
        NSArray *kvItems = [query componentsSeparatedByString:@"&"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
        for (NSString *kvItem in kvItems) {
            NSArray *kvs = [kvItem componentsSeparatedByString:@"="];
            [params setValue:kvs.lastObject forKey:kvs.firstObject];
        }
        if (params.allKeys.count>0) {
            return params;
        }
    }
    return nil;
}

@end
