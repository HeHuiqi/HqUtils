//
//  HqNewTopicCell.h
//  HqUtils
//
//  Created by hehuiqi on 2019/11/30.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqNewTopicHeaderView.h"
#import "HqNewTopicContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HqNewTopicCell : UITableViewCell

@property(nonatomic,strong) UIView *topLine;
@property(nonatomic,strong) HqNewTopicHeaderView *headerView;
@property(nonatomic,strong) HqNewTopicContainerView *topicContninerView;
@property(nonatomic,strong) NSArray *topics;


@end

NS_ASSUME_NONNULL_END
