//
//  HQSegmentPageViewController.h
//  HqUtils
//
//  Created by hehuiqi on 4/22/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "SuperVC.h"
#import "HqTableView.h"

#import "HqCustomPageContainerVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HQSegmentPageViewController : SuperVC

@property(nonatomic,strong) UIView *headerView;//可自定义配置
@property (nonatomic,strong) UISegmentedControl *segment;//可自定义配置

@property(nonatomic,strong) HqPageContainerVC *pageContainerVC;


@end

NS_ASSUME_NONNULL_END
