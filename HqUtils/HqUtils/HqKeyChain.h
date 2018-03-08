//
//  HqKeyChain.h
//  DaysDemo
//
//  Created by macpro on 16/4/26.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqKeyChain : NSObject
//service=key data=value
+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)deleteServer:(NSString *)service;

@end
