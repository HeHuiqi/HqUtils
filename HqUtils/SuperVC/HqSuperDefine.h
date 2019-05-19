//
//  HqSuperDefine.h
//  GlobalPay
//
//  Created by hqmac on 2018/7/17.
//  Copyright © 2018年 solar. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height
#define HqWZoomValue(value) (value*(SW/375.0))
#define HqHZoomValue(value) (value*(SH/667.0))

#define IS_iPhoneX (UIScreen.mainScreen.bounds.size.width >= 375.f && UIScreen.mainScreen.bounds.size.height >= 812.f)


#define HqTitleColor [UIColor blackColor]
#define HqTitleFontsize 18

#define HqNavBarColor [UIColor whiteColor]
#define HqBarBtnTintColor [UIColor whiteColor]

#define HqShadowHeight 2

@protocol HqSuperDefine <NSObject>

@end
