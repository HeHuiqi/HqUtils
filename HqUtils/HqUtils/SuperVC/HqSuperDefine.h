//
//  HqSuperDefine.h
//  GlobalPay
//
//  Created by hqmac on 2018/7/17.
//  Copyright © 2018年 solar. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HqDeviceHeight [UIScreen mainScreen].bounds.size.height

#define  IS_NOT_IPHONE_X ((HqDeviceHeight < 812.0f) ? 1 : 0)

#define HqTitleColor [UIColor blackColor]
#define HqTitleFontsize 18

#define HqNavBarColor [UIColor whiteColor]
#define HqBarBtnTintColor [UIColor whiteColor]

#define HqShadowHeight 2

@protocol HqSuperDefine <NSObject>

@end
