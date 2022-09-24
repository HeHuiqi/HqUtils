//
//  HqNightModeLayer.h
//  HqUtils
//
//  Created by hehuiqi on 2022/9/24.
//  Copyright © 2022 hhq. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#define  kNightModeIsOpen @"kNightModeIsOpen"
NS_ASSUME_NONNULL_BEGIN

@interface HqNightModeLayer : CAShapeLayer

+ (BOOL)isOpenNightMode;
+ (void)openNightMode:(BOOL)isOpen;

@end

NS_ASSUME_NONNULL_END
