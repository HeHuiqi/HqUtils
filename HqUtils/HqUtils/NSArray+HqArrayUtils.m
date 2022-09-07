//
//  NSArray+HqArrayUtils.m
//  LC
//
//  Created by hehuiqi on 2020/1/7.
//  Copyright © 2020 youfu. All rights reserved.
//

#import "NSArray+HqArrayUtils.h"

@implementation NSArray (HqArrayUtils)

//指定子数组大小分割数组，最后不足指定大小将剩余追加在最后
- (NSArray *)splitArrayWithSubArrayCount:(NSInteger)count{
    NSMutableArray *splitResult = [[NSMutableArray alloc] init];
    if (self.count>0) {
        NSInteger itemCount = self.count;
        NSInteger index = 0;
        while (itemCount) {
            NSInteger minLen = MIN(count, itemCount);
            NSRange subRange = NSMakeRange(index, minLen);
            NSArray *subItems = [self subarrayWithRange:subRange];
            [splitResult addObject:subItems];
            itemCount -= minLen;
            index += minLen;
        }
//        NSLog(@"splitResult==%@",splitResult);
    }
    return splitResult;
}

//指定子数组大小分割数组，最后不足指定大小将剩余追加在最后
- (NSArray *)splitArrayWithResult:(NSMutableArray *)splitResult subArrayCount:(NSInteger)count{
    if (self.count>0 && splitResult) {
        NSInteger itemCount = self.count;
        NSInteger index = 0;
        while (itemCount) {
            NSInteger minLen = MIN(count, itemCount);
            NSRange subRange = NSMakeRange(index, minLen);
            NSArray *subItems = [self subarrayWithRange:subRange];
            [splitResult addObject:subItems];
            itemCount -= minLen;
            index += minLen;
        }
//        NSLog(@"splitResult==%@",splitResult);
    }
    return splitResult;
}
//找出重复元素
- (NSArray *)findDuplicateItems2{
    if (self.count <=1) {
        return nil;
    }
    NSMutableArray *resultItems = @[].mutableCopy;
    for (NSInteger i = 0; i<self.count; i++) {
        id item = self[i];
        for (NSInteger j = i+1; j<self.count; j++) {
            id subItem = self[j];
            if ([item isEqual:subItem]) {
                [resultItems addObject:item];
            }
        }
    }
    return resultItems;
}
- (NSArray *)findDuplicateItems{
    if (self.count <=1) {
        return nil;
    }
    NSMutableArray *duplicateItem = @[].mutableCopy;
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (NSNumber * item  in self) {
        if (![set containsObject:item]) {
            [set addObject:item];
        }else{
            [duplicateItem addObject:item];
        }
    }
    return duplicateItem;
}
- (NSArray *)hqShuffle{
    NSMutableArray *items = self.mutableCopy;
    NSInteger i = self.count - 1;
    while (i > 0) {
        NSInteger random_index = arc4random() % (i + 1);
        id temp = items[i];
        items[i] = items[random_index];
        items[random_index] = temp;
        i -= 1;
    }
    return items;
}


@end
