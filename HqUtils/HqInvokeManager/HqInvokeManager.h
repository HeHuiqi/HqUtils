//
//  HqInvokeManager.h
//  HqTestdYSM
//
//  Created by hehuiqi on 6/12/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqInvokeManager : NSObject


@property (nonatomic,strong) NSObject *instance;
@property (nonatomic,strong) NSMutableDictionary *methodParams;
@property (nonatomic,strong) NSMutableArray *methods;
@property (nonatomic,assign) NSUInteger flag;

- (void)invokeInstance:(NSObject *)instance asyncMethod:(SEL)method;
- (void)invokeInstance:(NSObject *)instance asyncMethods:(NSArray<NSString *> *)methods;
- (void)start;
- (void)stop;


@end

NS_ASSUME_NONNULL_END
