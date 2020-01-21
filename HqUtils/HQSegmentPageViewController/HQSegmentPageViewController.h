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

@interface HQSegmentPageViewController : SuperVC<HqPageViewProtocol>

@property(nonatomic,assign) BOOL containerCanScroll;
@property(nonatomic,strong) HqTableView *mainTableView;
@property(nonatomic,strong) UIView *containerView;//
@property(nonatomic,strong) UIView *headerView;//可自定义实图添加在上面即可
@property (nonatomic,assign) CGFloat headerViewHeight;

@property(nonatomic,strong) UIView *sectionHeaderView;//可自定义配置
@property (nonatomic,assign) CGFloat sectionHeaderHeight;
@property (nonatomic,strong) UISegmentedControl *segment;//子类实现添加在sectionHeaderView

@property(nonatomic,strong) HqPageContainerVC *pageContainerVC;

//子类重写或直接调用
- (void)pageContainerScrollToindex:(NSInteger)index animated:(BOOL)animated;
- (void)mainTableviewDidScroll:(UIScrollView *)scrollView;

- (void)addRefreshUI;
- (void)refresh;
@end

NS_ASSUME_NONNULL_END
