//
//  HqChatNotifyCell.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqChatMessage.h"
NS_ASSUME_NONNULL_BEGIN

@interface HqChatNotifyCell : UITableViewCell

@property(nonatomic,strong) UILabel *notifyLab;

@property(nonatomic,strong) HqChatMessage *message;

@end

NS_ASSUME_NONNULL_END
