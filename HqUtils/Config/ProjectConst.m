//
//  ProjectConst.m
//  iRAIDLoop
//
//  Created by macpro on 16/8/2.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "ProjectConst.h"

@implementation ProjectConst

NSString * const kToken = @"iToken";
NSString * const kAid = @"kAid";
NSString * const kisLogin = @"isLogin";
NSString * const kLocalIsLogin = @"kLocalIsLogin";
NSString * const kLastWalletType = @"kLastWalletType";
NSString * const kLastMoneyType = @"kLastMoneyType";

NSString * const kisFirsUse = @"isFirsUse";
NSString * const kWalletAddress = @"kWalletAddress";
NSString * const kWalletMnemonic = @"kWalletMnemonic";
NSString * const kIsNewWallet = @"kIsNewWallet";
NSString * const kUserBankCardNumber = @"UserBankCardNumber";
NSString * const kUserPhoneNumber = @"UserPhoneNumber";
NSString * const kAddBankCardSuccess = @"kAddBankCardSuccess";
NSString * const kServerWalletAddress = @"kServerWalletAddress";

NSString * const kGesturePasswodStatus = @"kGesturePasswodStatus";//手势密码状态 1开启 0关闭
NSString * const kBaiduFaceStatus = @"kBaiduFaceStatus";//百度人脸状态 1开启 0关闭
NSString * const kUnLockSuccessNotification = @"kUnLockSuccessNotification";//手势解锁成功
NSString * const kNetworkStatus = @"kNetworkStatus";//网络状态 1开启 0关闭

//            @"^[a-zA-Z0-9_-]{6,16}$" 6-16密码
//            @"^(?=.*[a-zA-Z])(?=.*\\d).{6,18}$" 8-18字符+数字密码
//            @"^[^\\s]{8,18}$" // 不是空格
NSString * const kPasswordCheckRegex = @"^(?=.*[a-zA-Z])(?=.*\\d).{8,18}$";//密码正则匹配
NSString * const kMarkNameRegEx = @"^[a-zA-Z\u4E00-\u9FA5\\s\\d]*$";
NSString * const kSearchKeyRegEx = @"^[a-zA-Z\\s\\d]*$";
NSString * const kPhoneNumberRegEx = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
NSString * const kEmailRegEx = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
NSString * const kAddressRegEx = @"^(0x)?[0-9a-fA-F]{40}$";
NSString * const kCreateWallet = @"Create Wallet";


NSInteger const kPasswordLength = 6;
NSInteger const kContactNameLength = 12;

NSString * const kWallet1loginExperiedNotification = @"kWallet1loginExperiedNotification";
NSString * const kLocalDeleteNotification = @"kLocalDeleteNotification";

//机器人订单取消
NSString * const kRobotOrderCancelNotification = @"kRobotOrderCancelNotification";


NSString * const kOtcSellOrderUpdateNotification = @"kOtcSellOrderUpdateNotification";
NSString * const kOtcBuyOrderUpdateNotification = @"kOtcBuyOrderUpdateNotification";

NSString * const kOtcSellOrderConfirmSucceedNotification = @"kOtcSellOrderConfirmSucceedNotification";//卖家确认成功
NSString * const kOtcSellOrderPublishNotification = @"kOtcSellOrderPublishNotification";//卖家订单发布成功
NSString * const kOtcSellOrdeShensuSucceedNotification = @"kOtcSellOrdeShensuSucceedNotification";//卖家申诉

NSString * const kOtcBuyOrderPayComplateNotification = @"kOtcBuyOrderPayComplateNotification";//买家支付完成
NSUInteger const kTimerSecond = 10;


@end
