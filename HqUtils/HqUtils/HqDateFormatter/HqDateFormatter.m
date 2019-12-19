//
//  HqTimeFormatter.m
//  iRAIDWear
//
//  Created by macpro on 2017/4/25.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "HqDateFormatter.h"

@implementation HqDateFormatter

+ (instancetype)shareInstance{
    static HqDateFormatter *hqtime = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hqtime = [[HqDateFormatter alloc]init];
    });
    return hqtime;
}
- (NSString *)getNowTimeTimestamp{
    [self.dateForMatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateForMatter setTimeStyle:NSDateFormatterShortStyle];
    [self.dateForMatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [self.dateForMatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

#pragma mark - 时间戳-->字符串日期
- (NSString *)dateStringWithFormat:(NSString *)format timeInterval:(NSTimeInterval)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    [self.dateForMatter setDateFormat:format];
    NSString *dateStr = [self.dateForMatter stringFromDate:date];
    return dateStr;
}

#pragma mark - NSDate-->字符串日期
- (NSString *)dateStringWithFormat:(NSString *)format date:(NSDate *)date{
    [self.dateForMatter setDateFormat:format];
    NSString *dateStr = [self.dateForMatter stringFromDate:date];
    return dateStr;
}
#pragma mark - 字符串日期-->NSDate
- (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString{
    [self.dateForMatter setDateFormat:format];
    NSDate *date = [self.dateForMatter dateFromString:dateString];
    return date;
}
#pragma mark - 字符串日期-->另一个字符串日期
- (NSString *)dateString:(NSString *)dateString orginalFormat:(NSString *)orginal resultFormat:(NSString *)resultFormat{
    [self.dateForMatter setDateFormat:orginal];
    NSDate *date = [self.dateForMatter dateFromString:dateString];
    NSString *dateStr = [self dateStringWithFormat:resultFormat date:date];
    return dateStr;
}

- (NSDateFormatter *)dateForMatter{
    if (!_dateForMatter) {
        _dateForMatter = [[NSDateFormatter alloc]init];
    }
    return _dateForMatter;
}


+ (NSString *)convertDateString:(NSString *)dateString orginalFormat:(NSString *)orginal resultFormat:(NSString *)resultFormat{
    
    return [[HqDateFormatter shareInstance] dateString:dateString orginalFormat:orginal resultFormat:resultFormat];
}

//dateStr为这种格式 2019-04-19T02:38:41.000Z
- (NSString *)UTCDateStr:(NSString *)dateStr convertFormat:(NSString *)format{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *date = [df dateFromString:dateStr];
    NSTimeInterval interval = [timeZone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
//    NSLog(@"date----%@",date);
    
    [df setDateFormat:format];
    
    NSString *result = [df stringFromDate:date];
//    NSLog(@"result----%@",result);
    return result;
}
@end
