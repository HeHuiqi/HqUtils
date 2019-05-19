//
//  HqPageTempVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPageTempVC.h"

#import "HQPage1VC.h"
#import "HQPage2VC.h"
#import "HqPage3VC.h"

@interface HqPageTempVC ()<UITableViewDelegate,UITableViewDataSource,HqPageViewProtocol>

@property(nonatomic,strong) HqTableView *containerTableView;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,assign) BOOL containerCanScroll;
@property(nonatomic,strong) HQPage1VC *pageV1;
@property(nonatomic,strong) HQPage2VC *pageV2;
@property(nonatomic,strong) HqPage3VC *pageV3;



@property(nonatomic,strong) UIViewController *lastVC;

@property (nonatomic,strong) UISegmentedControl *segment;
@property (nonatomic,strong) UIScrollView *cellScrollView;
@property (nonatomic,assign) NSUInteger currentPageIndex;


@end

@implementation HqPageTempVC

- (void)refresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"end=endRefreshing=");
        [self.containerTableView.mj_header endRefreshing];
    });
    
    //更新当前ItemPage的数据
    HqPageItemSuperVC *vc = self.childViewControllers[self.currentPageIndex];
    [vc refreshData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //主视图
    [self.view addSubview:self.containerTableView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.containerTableView.mj_header = header;
    [self scrollViewDidScroll:self.containerTableView];
    self.containerTableView.tableHeaderView = self.headerView;
    
    self.containerCanScroll = YES;
    self.currentPageIndex = 0;
    
    /*
     //这里不用block
     __weak typeof(self) weakSelf = self;
     self.pageV1.pageItemOffsetYBlock = ^(HqPageItemViewSuperVC *vc, CGFloat offsetY) {
     __strong typeof(weakSelf) strongSelf = weakSelf;
     [strongSelf updateOtherItemVCToTopWithCurrentVC:vc];
     };
     self.pageV2.pageItemOffsetYBlock = ^(HqPageItemViewSuperVC *vc, CGFloat offsetY) {
     __strong typeof(weakSelf) strongSelf = weakSelf;
     [strongSelf updateOtherItemVCToTopWithCurrentVC:vc];
     };
     self.pageV3.pageItemOffsetYBlock = ^(HqPageItemViewSuperVC *vc, CGFloat offsetY) {
     __strong typeof(weakSelf) strongSelf = weakSelf;
     [strongSelf updateOtherItemVCToTopWithCurrentVC:vc];
     };
     */
    
}
#pragma mark - HqPageViewProtocol


- (void)hqPageItemVC:(HqPageItemSuperVC *)vc scrollViewOffetY:(CGFloat)offsetY{
    [self updateOtherItemVCToTopWithCurrentVC:vc];
}

#pragma mark - 更新其他Item到顶部
- (void)updateOtherItemVCToTopWithCurrentVC:(HqPageItemSuperVC *)currentVC{
    if (currentVC) {
        self.containerCanScroll = YES;
        NSArray *subvcs = self.childViewControllers;
        for (HqPageItemSuperVC *vc  in subvcs) {
            if (![vc isEqual:currentVC]) {
                [vc hqScorllToTop];
            }
        }
    }
}
#pragma mark - 更新Item的scrollview可滚动
- (void)updatePageItemCanScroll{
    NSArray *subvcs = self.childViewControllers;
    for (HqPageItemSuperVC *vc  in subvcs) {
        vc.canScroll = YES;
    }
}

- (UIScrollView *)cellScrollView{
    if (!_cellScrollView) {
        CGFloat height = SCREEN_HEIGHT-self.navBarheight;
        
        _cellScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        _cellScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, height);
        _cellScrollView.pagingEnabled = YES;
        _cellScrollView.delegate = self;
    }
    return _cellScrollView;
}
- (void)setContainerCanScroll:(BOOL)containerCanScroll{
    _containerCanScroll = containerCanScroll;
    self.containerTableView.showsVerticalScrollIndicator = _containerCanScroll;
}

#pragma mark get
- (UIScrollView *)containerTableView{
    if (!_containerTableView) {
        CGRect rect = CGRectMake(0, self.navBarheight, self.view.bounds.size.width, self.view.bounds.size.height-self.navBarheight);
        _containerTableView = [[HqTableView alloc] initWithFrame:rect];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _containerTableView.alwaysBounceVertical = YES;
    }
    return _containerTableView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.frame = CGRectMake(0, self.navBarheight, self.view.bounds.size.width, 200);
        _headerView.backgroundColor = [UIColor greenColor];
    }
    return _headerView;
}
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
- (void)segChange:(UISegmentedControl *)sg{
    
    NSInteger index = sg.selectedSegmentIndex;
    CGPoint offset = CGPointMake(index*SCREEN_WIDTH, 0);
    [self.cellScrollView setContentOffset:offset animated:YES];
}
- (HQPage1VC *)pageV1{
    if (!_pageV1) {
        _pageV1 = [[HQPage1VC alloc] init];
        _pageV1.title = @"HQPage1VC";
        _pageV1.delegate = self;
        
    }
    return _pageV1;
}

- (HQPage2VC *)pageV2{
    if (!_pageV2) {
        _pageV2 = [[HQPage2VC alloc] init];
        _pageV2.title = @"HQPage2VC";
        _pageV2.delegate = self;
    }
    return _pageV2;
}
- (HqPage3VC *)pageV3{
    if (!_pageV3) {
        _pageV3 = [[HqPage3VC alloc] init];
        _pageV3.title = @"HQPage3VC";
        _pageV3.delegate = self;
        
    }
    return _pageV3;
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *shv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    shv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [shv addSubview:self.segment];
    return shv;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT-self.navBarheight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"13"];
    
    [cell addSubview:self.cellScrollView];
    
    [self addChildViewController:self.pageV1];
    [self.cellScrollView addSubview:self.pageV1.view];
    self.pageV1.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.cellScrollView.bounds.size.height);
    
    [self addChildViewController:self.pageV2];
    [self.cellScrollView addSubview:self.pageV2.view];
    self.pageV2.view.frame = CGRectMake(SCREEN_WIDTH,0 , SCREEN_WIDTH, self.cellScrollView.bounds.size.height);
    
    [self addChildViewController:self.pageV3];
    [self.cellScrollView addSubview:self.pageV3.view];
    self.pageV3.view.frame = CGRectMake(SCREEN_WIDTH*2,0 , SCREEN_WIDTH, self.cellScrollView.bounds.size.height);
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.cellScrollView]) {
        self.containerTableView.scrollEnabled = YES;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.cellScrollView]) {
        self.containerTableView.scrollEnabled = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if ([scrollView isEqual:self.cellScrollView]) {
        CGFloat x = scrollView.contentOffset.x;
        NSInteger index = (NSInteger)x/SCREEN_WIDTH;
        self.segment.selectedSegmentIndex = index;
        self.currentPageIndex = index;
    }else{
        
        CGFloat y = scrollView.contentOffset.y;
        CGFloat shvY = [self.containerTableView rectForHeaderInSection:0].origin.y;
        
        if (y>=shvY) {
            self.containerCanScroll = NO;
            scrollView.contentOffset = CGPointMake(0, shvY);
            [self updatePageItemCanScroll];
        }else{
            if (!self.containerCanScroll) {
                scrollView.contentOffset = CGPointMake(0, shvY);
                [self updatePageItemCanScroll];
                
            }
        }
    }
}

@end

