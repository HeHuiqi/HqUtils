//
//  HqNewTopicControl.h
//  LC
//
//  Created by hehuiqi on 2019/11/30.
//  Copyright © 2019 youfu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqNewTopicItemBtn : UIButton

@property(nonatomic,strong) UILabel *topicNameLab;
@property(nonatomic,strong) UIImageView *topicFlagIcon;
@property(nonatomic,assign) BOOL haveFlag;
@property(nonatomic,assign) CGFloat flagWith;

@property(nonatomic,strong)  id topic;

@end

NS_ASSUME_NONNULL_END
