//
//  NSObject+HqKVO.h
//  HqiOS-In-Action
//
//  Created by hqmac on 2019/1/22.
//  Copyright © 2019 HHQ. All rights reserved.
//
/*
 test:
 //user
 User *u = [[User alloc] init];
 [u Hq_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
 self.u = u;
 
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HqKVO)
- (void)Hq_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end

NS_ASSUME_NONNULL_END
