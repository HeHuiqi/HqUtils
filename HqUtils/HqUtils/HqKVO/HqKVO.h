//
//  HqKVO.h
//  HqTestDemo
//
//  Created by hqmac on 2019/2/25.
//  Copyright © 2019 HHQ. All rights reserved.
//
// 封装系统KVO使用block回调形式，再也不用管理移除的问题
// 一个key对应一个回调，使用方式见 HqKVOTestVC 类
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//注意要使用时要声明为全局属性
typedef void(^HqKVOCallback)(NSString *keyPath,NSDictionary<NSKeyValueChangeKey,id> *change);

@interface HqKVO : NSObject


- (void)hq_addObserver:(id)observer keyPath:(NSString *)keyPath callback:(HqKVOCallback)callBack;


@end

NS_ASSUME_NONNULL_END
