//
//  HqChatVC.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "SuperVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqChatVC : SuperVC

@property(nonatomic,strong) JMSGChatRoom *chatRoom;
@property(nonatomic,strong) JMSGUser *loginUser;

@end

NS_ASSUME_NONNULL_END
