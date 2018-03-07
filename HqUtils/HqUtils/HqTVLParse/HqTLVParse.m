//
//  HqTLVParse.m
//  HqTLVParse
//
//  Created by macpro on 2017/8/9.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "HqTLVParse.h"

@implementation HqTLVParse

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (NSDictionary<NSString *,HqTLVParse *> *)parseMutilTVLStrToDic:(NSString *)tlvstr{
    
    NSMutableDictionary *tlvs = [[NSMutableDictionary alloc]initWithCapacity:0];
    while (tlvstr.length>0) {
//        NSLog(@"tlvstr == %@",tlvstr);
        HqTLVParse *parse = [self parseTLVStr:tlvstr];
        tlvstr = [tlvstr substringFromIndex:parse.tlvLength];
        if (parse) {
            tlvs[parse.tag] = parse;
        }else{
            break;
        }
    }
    return tlvs;
    
}
- (NSArray<HqTLVParse *> *)parseMutilTVLStrToArray:(NSString *)tlvstr{
    
    NSMutableArray *tlvs = [NSMutableArray arrayWithCapacity:0];
    
    while (tlvstr.length>0) {
//        NSLog(@"tlvstr == %@",tlvstr);

        HqTLVParse *parse = [self parseTLVStr:tlvstr];
        tlvstr = [tlvstr substringFromIndex:parse.tlvLength];
        if (parse) {
            [tlvs addObject:parse];
        }else{
            break;
        }
    }
    
    return tlvs;
    
}
// 可添加自己设置的tag值即可解析
- (id)parseTLVStr:(NSString *)dataStr{
    
    //    一个TLV格式的字符长度至少为6 比如 4F(t) 01(l) 88(v)
    if (dataStr.length<6) {
        return nil;
    }
    
    dataStr = dataStr.uppercaseString;
    
    
    //默认为两位tag
    int tagLength = 2;
    NSInteger tlvLength = 0;
    NSString *dataStrLengthStr = @"";
    
    //两位tag
    NSString *tag = [dataStr substringWithRange:NSMakeRange(0, tagLength)];
    
    //默认为两位tag，所以仅处理4位tag的情况，其他情况自行处理
    if ([tag isEqualToString:@"9F"]||
        [tag isEqualToString:@"01"]) {
        NSString *lTag = [dataStr substringWithRange:NSMakeRange(tagLength, 2)];
        if ([lTag isEqualToString:@"70"]||
            [lTag isEqualToString:@"0A"]) {
            tagLength = 4;
        }
        if (dataStr.length<8) {
            return nil;
        }
    }
    
    //处理完要再次取tag值
    tag = [dataStr substringWithRange:NSMakeRange(0, tagLength)];
    
    //数据长度字符串
    dataStrLengthStr = [dataStr substringWithRange:NSMakeRange(tagLength, 2)];
    
    //数据长度要乘以2才是数据真正的长度
    NSUInteger dataStrLength = [self hexStrTolong:dataStrLengthStr]*2;
    NSString *dataStrValue = [dataStr substringWithRange:NSMakeRange(tagLength+dataStrLengthStr.length, dataStrLength)];
    tlvLength = tag.length+dataStrLengthStr.length+dataStrValue.length;
    
    HqTLVParse *parse = [[HqTLVParse alloc]init];
    parse.tag = tag;
    parse.length = dataStrLength;
    parse.value = dataStrValue;
    parse.tlvLength  = tlvLength;
    
    return parse;
}
#pragma mark - 十六进制字符串转long
- (NSUInteger )hexStrTolong:(NSString *)hexStr{
    char *rest = (char *)[hexStr UTF8String];
    unsigned long sum = 0;
    for (int i = 0; i<hexStr.length; i++) {
        char j[1] = {rest[i]};
        unsigned long k =  strtoul(j,0,16);
        sum = sum + k*powf(16, hexStr.length - i - 1);
    }
    return sum;
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"HqTLVParse=[tag=%@,length=%@,v=%@,tlvlength=%@]",self.tag,@(self.length),self.value,@(self.tlvLength)];
}
@end
