//
//  ProjectDefine.h
//  HHQ
//
//  Created by macpro on 16/7/12.
//  Copyright © 2016年 macpro. All rights reserved.
//

#ifndef ProjectDefine_h
#define ProjectDefine_h

#define GetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define SetUserDefault(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];

#define SetUserIntegerDefault(MyInteger,key)  [[NSUserDefaults standardUserDefaults] setInteger:MyInteger forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];

#define GetUserIntegerDefault(key)  [[NSUserDefaults standardUserDefaults] integerForKey:key]

#define SetUserBoolDefault(MyBool,key)  [[NSUserDefaults standardUserDefaults] setBool:MyBool forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define GetUserBoolDefault(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]


#define HqDINCond_BoldFontPath [[NSBundle mainBundle] pathForResource:@"DINCond-Bold" ofType:@"otf"]

#pragma mark -  颜色设置
#define COLORA(R, G, B)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

#define COLOR(R, G, B, A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//根据16进制颜色值得到颜色，eg:COLOR_RGB(0x666666,1)
#define HqHexColorA(hex, A)   [UIColor colorWithRed:(((hex >> 16) & 0xff) / 255.0) green:(((hex >> 8) & 0xff) / 255.0) blue:((hex & 0xff) / 255.0) alpha:A]
#define HqHexColor(hex) HqHexColorA(hex,1)
#define HqRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]
#define HqBlueThemeColors @[HqHexColor(0x00c6ff),HqHexColor(0x0072ff)]
#define HqBtnBlueThemeColors @[HqHexColor(0x0072ff),HqHexColor(0x00c6ff)]


#define HqOrangeThemeColors @[HqHexColor(0x00c6ff),HqHexColor(0x0072ff)]
#define HqTableBagColor HqHexColor(0xf8f8f8)

#define AppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]

#define kRequestError @"Sorry,Request Fail!"

#define kMobileNumberLength 11
#define kMobileNumberMinLength 10
#define kPasswordMaxLength 14
#define kPsswordMinLength 6
#define kCheckCodeMaxLength 6
#define kHqCornerRadius 3.0
#define kHqAddCoinMaxCount 10


#define AppMainColor HqHexColor(0x212c67)
#define HqOrangeColor HqHexColor(0xfcae06)
#define HqGrayColor HqHexColor(0x808080)
#define HqLightGrayColor HqHexColor(0xc3c3c3)
#define HqGreenColor COLOR(18, 124, 3, 1)
#define HqDeepGrayColor COLOR(102, 102, 102, 1)
#define HqBlackColor COLOR(51, 51, 51, 1)
#define HqBorderColor  COLORA(230,230,230)
#define HqHighlightedColor [UIColor colorWithWhite:1.0 alpha:0.5]

//#define LineColor COLOR(224, 224, 224, 1)
#define LineColor COLOR(200, 199, 204, 1)

#define LineHeight (1.0/[UIScreen mainScreen].scale)
#define AppLightColor [UIColor colorWithHex:0x999999]
#define HqLeftViewWidthRate 0.8



#pragma mark -  函数宏
#define SetFont(size)  [UIFont systemFontOfSize:size]
#define SetFontDINCond(fsize) [UIFont customFontWithPath:HqDINCond_BoldFontPath size:fsize]

#define Alert(string)  [[[UIAlertView alloc] initWithTitle:nil message:string delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#define Push(VC)  VC.hidesBottomBarWhenPushed = YES;\
[self.navigationController pushViewController:VC animated:YES]

#define Present(VC) [self presentViewController:VC animated:YES completion:nil]

#define Dismiss() [self dismissViewControllerAnimated:YES completion:nil]

#define Back() [self.navigationController popViewControllerAnimated:YES]

#define BackRoot() [self.navigationController popToRootViewControllerAnimated:YES]

#pragma mark - UIKit
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width     //屏幕宽度

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度
#define kZoomScale (SCREEN_WIDTH/375.0)
//value是pt
#define kZoomValue(value) value*kZoomScale


//log--------
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

//#define NSLog( s, ...) NSLog(@"\nfunction:%s,line:%d \n%@",__FUNCTION__,__LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__]);

#elif Qa
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#elif Prd
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#else
#define NSLog( s, ...);
//#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#endif
//-------

#define weakly(target) __weak typeof(target) JC_WeakTarget = target;
#define strongly(target) __strong typeof(target) target = JC_WeakTarget;

#endif


/* ProjectDefine_h */
