//
//  HqRegEx.m
//  HqUtils
//
//  Created by hqmac on 2019/1/4.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqRegEx.h"

@implementation HqRegEx

//提取字符串
+ (void)extractStr{
    NSString *orignalStr = @"eos:cobowalletio?memo=1e892fee";
    NSString *regStr = @"[:|=]([^\?]){0,}";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regStr options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSMutableArray* stringArray = [[NSMutableArray alloc] init];
    [regEx enumerateMatchesInString:orignalStr options:NSMatchingReportCompletion range:NSMakeRange(0, orignalStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        //从NSTextCheckingResult类中取出range属性
        NSRange range = result.range;
        NSLog(@"range=== %@",@(range.length));
        if (range.length>0) {
            /*
             这里处理一下，不处理将返回如下
             :cobowalletio,
             =1e892fee
             */
            range.location = range.location+1;
            range.length = range.length -1;
            //从原文本中将字段取出并存入一个NSMutableArray中
            [stringArray addObject:[orignalStr substringWithRange:range]];
        }
    }];
    NSUInteger number = [regEx numberOfMatchesInString:orignalStr options:NSMatchingReportCompletion range:NSMakeRange(0, orignalStr.length)];
    //这里如果number大于0说明字符串符合正则规则
    NSLog(@"number == %@",@(number));
    NSLog(@"%@",stringArray);
}

@end
