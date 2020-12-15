//
//  HqWeakTarget.h
//  HqUtils
//
//  Created by hehuiqi on 2020/12/15.
//  Copyright © 2020 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqWeakTarget : NSObject

+(instancetype)weakTarget:(id)target;

-(instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
