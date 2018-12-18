//
//  NSObject+HqSafeGetValue.m
//  GlobalPay
//
//  Created by hqmac on 2018/11/27.
//  Copyright © 2018 solar. All rights reserved.
//

#import "NSObject+HqSafeGetValue.h"

@implementation NSObject (HqSafeGetValue)

- (id)hq_objectForKey: (NSString *) key
{
    if (![self isKindOfClass:NSDictionary.class]) {
        return nil;
    }
    NSDictionary *dic = (NSDictionary *)self;
    NSArray *keys = dic.allKeys;
    if (![keys containsObject:key]) {
        return nil;
    }
    id obj = [dic objectForKey: key];
    
    if ([obj isKindOfClass: [NSNull class]])
    {
        return nil;
    }
    return obj;
}
- (id)hq_vauleWithIndex:(NSInteger)index{
    if (![self isKindOfClass:NSArray.class]) {
        return nil;
    }
    NSArray *array = (NSArray *)self;
    if (index < array.count) {
        return array[index];
    }
    return nil;
}

@end
