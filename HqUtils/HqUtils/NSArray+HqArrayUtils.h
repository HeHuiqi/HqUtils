//
//  NSArray+HqArrayUtils.h
//  LC
//
//  Created by hehuiqi on 2020/1/7.
//  Copyright © 2020 youfu. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HqArrayUtils)

//置顶子数组大小分割数组，最后不足指定大小将剩余追加在最后
- (NSArray *)splitArrayWithSubArrayCount:(NSInteger)count;
//指定子数组大小分割数组，最后不足指定大小将剩余追加在最后
- (NSArray *)splitArrayWithResult:(NSMutableArray *)splitResult subArrayCount:(NSInteger)count;
//找出重复元素
- (NSArray *)findDuplicateItems2;
- (NSArray *)findDuplicateItems;
//洗牌打乱
- (NSArray *)hqShuffle;

@end

NS_ASSUME_NONNULL_END
