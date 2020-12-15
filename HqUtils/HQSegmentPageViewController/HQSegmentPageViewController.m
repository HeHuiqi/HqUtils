//
//  HQSegmentPageViewController.m
//  HqUtils
//
//  Created by hehuiqi on 4/22/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HQSegmentPageViewController.h"
@interface HQSegmentPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HQSegmentPageViewController

- (instancetype)init{
    if (self = [super init]) {
        //默认值
        self.containerCanScroll = YES;
        self.headerViewHeight = 200;
        self.sectionHeaderHeight = 50;
    }
    return self;
}
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}
- (void)refresh{
    
    //更新当前ItemPage的数据
    [self.pageContainerVC refreshCurrentItemData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //主视图
    [self.view addSubview:self.mainTableView];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {

    }
    self.mainTableView.tableHeaderView = self.headerView;
    [self addChildViewController:self.pageContainerVC];

    
}
- (void)addRefreshUI{
    //添加下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.mainTableView.mj_header = header;
    [self.view addSubview:self.containerView];
}
#pragma mark - set
- (void)setContainerCanScroll:(BOOL)containerCanScroll{
    _containerCanScroll = containerCanScroll;
    self.mainTableView.showsVerticalScrollIndicator = _containerCanScroll;
}
- (void)setHeaderViewHeight:(CGFloat)headerViewHeight{
    _headerViewHeight = headerViewHeight;
    if (_headerViewHeight>0) {
        CGRect bounds = self.headerView.bounds;
        bounds.size.height = _headerViewHeight;
        self.headerView.bounds = bounds;
        self.mainTableView.tableHeaderView = self.headerView;
    }
}
- (void)setSectionHeaderHeight:(CGFloat)sectionHeaderHeight{
    _sectionHeaderHeight = sectionHeaderHeight;
    if (_sectionHeaderHeight>0) {
        CGRect bounds = self.sectionHeaderView.bounds;
        bounds.size.height = _sectionHeaderHeight;
        self.sectionHeaderView.bounds = bounds;
        [self.mainTableView reloadData];
    }
}

#pragma mark get
- (UIScrollView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[HqTableView alloc] initWithFrame:CGRectZero];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.alwaysBounceVertical = YES;
    }
    return _mainTableView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, _headerViewHeight);
        _headerView.backgroundColor = [UIColor greenColor];
    }
    return _headerView;
}
- (UIView *)sectionHeaderView{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[UIView alloc] init];
        _sectionHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _sectionHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.sectionHeaderHeight);
    }
    return _sectionHeaderView;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"self.view==%@",self.view);
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height - self.navBarHeight;
    self.mainTableView.frame = CGRectMake(0, self.navBarHeight, width, height);
    self.sectionHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.sectionHeaderHeight);
    
    //配置自己的分段视图
//      self.segment.center = self.sectionHeaderView.center;
}
//自行改变
- (UISegmentedControl *)segment{
    if (!_segment) {
        
        UISegmentedControl *sg = [[UISegmentedControl alloc] initWithItems:@[@"P1",@"p2",@"p3"]];
        sg.frame  = CGRectMake(0, 10, SCREEN_WIDTH, 30);
        [sg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
        sg.selectedSegmentIndex = 0;
        _segment = sg;
    }
    return _segment;
}
//自己实现
- (void)segChange:(UISegmentedControl *)sg{
    
    NSInteger index = sg.selectedSegmentIndex;
    
    [self pageContainerScrollToindex:index animated:YES];
    
}
- (void)pageContainerScrollToindex:(NSInteger)index animated:(BOOL)animated{
    [self.pageContainerVC scrollToIndex:index animated:animated];

}
//设置自定义的HqCustomPageContainerVC
- (HqPageContainerVC *)pageContainerVC{
    if (!_pageContainerVC) {
        _pageContainerVC = [[HqCustomPageContainerVC alloc] init];
        _pageContainerVC.delegate = self;
    }
    return _pageContainerVC;
}
#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.bounds.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    self.containerView.backgroundColor = HqRandomColor;
    [cell addSubview:self.containerView];
    self.containerView.frame = CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height-self.navBarHeight);
    [self.containerView addSubview:self.pageContainerVC.view];
    self.pageContainerVC.view.frame = self.containerView.frame;

    return cell;
}

#pragma mark - HqPageViewProtocol
- (void)mainScrollViewCanScroll{
    self.containerCanScroll = YES;
}
- (void)pageContainerScrollViewToIndex:(NSInteger)index{
    self.segment.selectedSegmentIndex = index;
}
- (void)mainScrollViewScrollEnabled:(BOOL)scrollEnabled{
    self.mainTableView.scrollEnabled = scrollEnabled;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    NSInteger sectionCount = [self.mainTableView numberOfSections];
    NSInteger section = sectionCount - 1;
    
    CGFloat shvY = [self.mainTableView rectForHeaderInSection:section].origin.y;
    if (y>=shvY) {
        self.containerCanScroll = NO;
        scrollView.contentOffset = CGPointMake(0, shvY);
        [self.pageContainerVC updatePageItemCanScroll];
    }else{
        if (!self.containerCanScroll) {
            scrollView.contentOffset = CGPointMake(0, shvY);
            [self.pageContainerVC updatePageItemCanScroll];
        }
    }
    
    [self mainTableviewDidScroll:scrollView];
}

- (void)mainTableviewDidScroll:(UIScrollView *)scrollView{
    //子类实现
}

@end
