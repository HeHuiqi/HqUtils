//
//  ProjectConst.h
//  iRAIDLoop
//
//  Created by macpro on 16/8/2.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectConst : NSObject

extern NSString * const kToken;
extern NSString * const kAid;
extern NSString * const kisLogin;
extern NSString * const kLocalIsLogin;
extern NSString * const kLastWalletType;
extern NSString * const kLastMoneyType;
extern NSString * const kisFirsUse;
extern NSString * const kUserId;
extern NSString * const kWalletAddress;//ETH地址
extern NSString * const kWalletMnemonic;//钱包助记词
extern NSString * const kServerWalletAddress;//服务端ETH地址，用于验证签名

extern NSString * const kIsNewWallet;//是否是新钱包
extern NSString * const kGesturePasswodStatus;//手势密码状态 1开启 0关闭
extern NSString * const kBaiduFaceStatus;//百度人脸状态 1开启 0关闭
extern NSString * const kNetworkStatus;//网络状态 1开启 0关闭


extern NSString * const kMarkNameRegEx;
extern NSString * const kSearchKeyRegEx;


extern NSString * const kUserPhoneNumber;
extern NSString * const kUserBankCardNumber;
extern NSString * const kPasswordCheckRegex;
extern NSString * const kPhoneNumberRegEx;
extern NSString * const kEmailRegEx;
extern NSString * const kAddressRegEx;

extern NSString * const kUnLockSuccessNotification;//手势解锁成功

extern NSString * const kLoginSuccessNotification;
extern NSString * const kWallet1loginExperiedNotification;

//机器人订单取消
extern NSString * const kRobotOrderCancelNotification;

extern NSString * const kRegistSuccessNotification;
extern NSString * const kAddBankCardSuccess;

extern NSString * const kCreateWallet;

extern NSInteger const kPasswordLength;
extern NSInteger const kContactNameLength;
extern NSString * const kLocalDeleteNotification;


extern NSString * const kOtcSellOrderUpdateNotification;//卖家订单更新
extern NSString * const kOtcBuyOrderUpdateNotification;//买家订单更新

extern NSString * const kOtcSellOrderConfirmSucceedNotification ;//卖家确认成功
extern NSString * const kOtcSellOrdeShensuSucceedNotification;//卖家申诉
extern NSString * const kOtcSellOrderPublishNotification;//卖家订单发布成功
extern NSString * const kOtcBuyOrderPayComplateNotification;//买家支付完成

extern NSUInteger const kTimerSecond;


@end
