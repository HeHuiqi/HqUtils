//
//  HqKVO.m
//  HqTestDemo
//
//  Created by hqmac on 2019/2/25.
//  Copyright © 2019 HHQ. All rights reserved.
//

#import "HqKVO.h"

@interface HqKVO()

@property (nonatomic,strong) NSMutableDictionary *kvos;//所有的被观察者
@property (nonatomic,strong) NSMutableDictionary *allCallbacks;//被观察者改变时，触发对应keyPath的回调

@end

@implementation HqKVO

- (instancetype)init{
    if (self = [super init]) {
        self.kvos = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.allCallbacks = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return self;
}

- (void)dealloc{
    
    NSArray *allkeys = self.kvos.allKeys;
    if (allkeys.count>0) {
        for (NSString *keyPath in allkeys) {
            id observer = [self.kvos objectForKey:keyPath];
            [observer removeObserver:self forKeyPath:keyPath];
        }
    }
}
- (void)hq_addObserver:(id)observer keyPath:(NSString *)keyPath callback:(HqKVOCallback)callBack{
    
    [observer addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];
    
    NSArray *allkeys = self.kvos.allKeys;
    if (![allkeys containsObject:keyPath]) {
        [self.kvos setObject:observer forKey:keyPath];
        [self.allCallbacks setValue:callBack forKey:keyPath];
    }

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSArray *allCallbackKeys = self.allCallbacks.allKeys;
    if ([allCallbackKeys containsObject:keyPath]) {
        HqKVOCallback cb = self.allCallbacks[keyPath];
        if (cb) {
            cb(keyPath,change);
        }
    }
}


@end
