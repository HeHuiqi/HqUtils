//
//  HqDeviceInfo.h
//  DaysDemo
//
//  Created by macpro on 16/4/12.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqDeviceInfo : NSObject

#pragma mark - 获得设备型号
- (NSString *)deviceModel;
#pragma mark - SSID
- (NSString *) getDeviceSSID;
#pragma mark -  Get IP Address
- (NSString *)getDeviceIPIpAddresses;
#pragma mark - 获取mac地址始终时 02:00:00:00:00
- (NSString *)getMacAddress;
#pragma mark - 获取网络运行商
- (NSString *)getNetProvider;

@end
