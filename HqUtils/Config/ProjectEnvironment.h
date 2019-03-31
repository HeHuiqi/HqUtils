//
//  ProjectEnvironment.h
//  iRAIDWear
//
//  Created by macpro on 2017/4/7.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG


#define  HqMobile @"15802174518"
#define  HqEmail  @"1710308677@qq.com"
#define  HqPassword @"q12345678"

//#define SERVER  @"http://192.168.1.102:9000"

#define SERVER  @"https://api.lcyoufu.com"

#elif Qa

#define SERVER  @"https://api.lcyoufu.com"


#else
#define SERVER  @"https://api.lcyoufu.com"

#endif

#define SERVSER_URL   [NSString stringWithFormat:@"%@/v1",SERVER]


@interface ProjectEnvironment : NSObject

@end
