//
//  HqWeakTarget.m
//  HqUtils
//
//  Created by hehuiqi on 2020/12/15.
//  Copyright © 2020 hhq. All rights reserved.
//

#import "HqWeakTarget.h"


@interface HqWeakTarget ()

@property (nonatomic,weak) id target;

@end

@implementation HqWeakTarget

-(instancetype)initWithTarget:(id)target{
    _target=target;
    return self;
}

+(instancetype)weakTarget:(id)target{
    return [[HqWeakTarget alloc]initWithTarget:target];
}

/**
 消息转发
 @param aSelector <#aSelector description#>
 @return <#return value description#>
 */
-(id)forwardingTargetForSelector:(SEL)aSelector{
    return _target;
}


@end
