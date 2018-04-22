//
//  NSArray+SafeGetValue.m
//  iRAIDWear
//
//  Created by macpro on 2017/6/14.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "NSArray+SafeGetValue.h"

@implementation NSArray (SafeGetValue)

- (id)safeGetArrayValueWithIndex:(NSUInteger)index{
    id value = nil;
    if (index<self.count) {
        value = self[index];
    }
    return value;
}

@end
