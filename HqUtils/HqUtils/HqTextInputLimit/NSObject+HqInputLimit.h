//
//  NSObject+HqInputLimit.h
//  GlobalPay
//
//  Created by hqmac on 2018/8/7.
//  Copyright © 2018年 solar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HqInputLimit)

@property (nonatomic,assign) NSUInteger hqMaxLength;

- (void)hqTextDidChangeNotifi:(NSNotification *)notif;

@end
