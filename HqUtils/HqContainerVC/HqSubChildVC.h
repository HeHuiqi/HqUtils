//
//  HqSubChildVC.h
//  HqUtils
//
//  Created by hehuiqi on 2019/11/29.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqSubChildVC : UIViewController

@property(nonatomic,assign) BOOL canScroll;
@property(nonatomic,strong) UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
