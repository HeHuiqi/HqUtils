//
//  NSArray+SafeGetValue.h
//  iRAIDWear
//
//  Created by macpro on 2017/6/14.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeGetValue)

- (id)safeGetArrayValueWithIndex:(NSUInteger)index;

@end
