//
//  HqTLVParse.h
//  HqTLVParse
//
//  Created by macpro on 2017/8/9.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqTLVParse : NSObject

@property (nonatomic,assign) NSUInteger tlvLength;
@property (nonatomic,copy) NSString *tag;
@property (nonatomic,assign) NSUInteger length;
@property (nonatomic,copy) NSString *value;

//解析多个个tlv组成的字符串返回字典
- (NSDictionary<NSString *,HqTLVParse *> *)parseMutilTVLStrToDic:(NSString *)tlvstr;

//解析多个个tlv组成的字符串数组
- (NSArray<HqTLVParse *> *)parseMutilTVLStrToArray:(NSString *)tlvstr;


//解析一个tlv字符串
- (HqTLVParse *)parseTLVStr:(NSString *)dataStr;

@end
