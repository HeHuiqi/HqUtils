//
//  HqNotification.h
//  HqTestDemo
//
//  Created by hqmac on 2019/2/25.
//  Copyright © 2019 HHQ. All rights reserved.
//

#import <Foundation/Foundation.h>
// 封装系统NSNotificationCenter使用block回调形式，再也不用管理移除的问题
// 使用方式见 HqKVOTestVC 类
NS_ASSUME_NONNULL_BEGIN

//注意要使用时要声明为全局属性
typedef void(^HqNotificationCallback)(id params);

@interface HqNotification : NSObject

@property (nonatomic,copy) HqNotificationCallback callBack;

- (void)hqOberverNotifyName:(NSString *)name callBack:(HqNotificationCallback)callBack;

@end

NS_ASSUME_NONNULL_END
