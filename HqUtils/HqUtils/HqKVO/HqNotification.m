//
//  HqNotification.m
//  HqTestDemo
//
//  Created by hqmac on 2019/2/25.
//  Copyright © 2019 HHQ. All rights reserved.
//

#import "HqNotification.h"
@interface HqNotification()

@end
@implementation HqNotification

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)hqOberverNotifyName:(NSString *)name callBack:(HqNotificationCallback)callBack{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hqNotifyCallback:) name:name object:nil];
    self.callBack = callBack;
}
- (void)hqNotifyCallback:(NSNotification *)notify{
    if (self.callBack) {
        self.callBack(notify.object);
    }
}
@end
