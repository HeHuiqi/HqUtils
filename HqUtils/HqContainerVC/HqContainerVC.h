//
//  HqContainerVC.h
//  HqUtils
//
//  Created by hehuiqi on 2019/11/29.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "SuperVC.h"
#import "HqTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqContainerVC : SuperVC

@property(nonatomic,assign) BOOL canScroll;
@property(nonatomic,strong) HqTableView *tableView;

@end

NS_ASSUME_NONNULL_END
