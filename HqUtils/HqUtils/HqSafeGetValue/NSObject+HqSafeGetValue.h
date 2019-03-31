//
//  NSObject+HqSafeGetValue.h
//  GlobalPay
//
//  Created by hqmac on 2018/11/27.
//  Copyright © 2018 solar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HqSafeGetValue)

//NSDictionary
- (id)hq_objectForKey: (NSString *) key;

//NSArray
- (id)hq_vauleWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
