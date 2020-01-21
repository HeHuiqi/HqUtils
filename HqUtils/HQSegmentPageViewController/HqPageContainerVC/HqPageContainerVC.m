//
//  HqPageContainerVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPageContainerVC.h"
#import "HqPageItemSuperVC.h"

@interface HqPageContainerVC ()<HqPageViewProtocol>

@end

@implementation HqPageContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPageIndex = 0;
    [self.view addSubview:self.containerScrollview];
}
- (void)hqAddChildVCWithindex:(NSInteger)index{
    NSArray *subvcs  = self.childViewControllers;
    CGFloat height = self.containerScrollview.bounds.size.height;
    CGFloat width  = self.containerScrollview.bounds.size.width;
    UIViewController *vc = self.pageItems[index];
    if (![subvcs containsObject:vc]) {
        [self addChildViewController:vc];
        [self.containerScrollview addSubview:vc.view];
        vc.view.frame = CGRectMake(width*index, 0, width, height);
    }
}
- (void)setPageItems:(NSArray *)pageItems{
    _pageItems = pageItems;
    if (_pageItems.count>0) {
        for (HqPageItemSuperVC *vc  in _pageItems) {
            vc.delegate = self;
        }
    }
}

- (UIScrollView *)containerScrollview{
    if (!_containerScrollview) {        
        _containerScrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _containerScrollview.pagingEnabled = YES;
        _containerScrollview.delegate = self;
    }
    return _containerScrollview;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
   self.containerScrollview.frame = CGRectMake(0, 0, width, height);
   self.containerScrollview.contentSize = CGSizeMake(self.pageItems.count*width, height);
}

#pragma mark - HqPageViewProtocol
- (void)hqPageItemVC:(HqPageItemSuperVC *)vc scrollViewOffetY:(CGFloat)offsetY{
    [self updateOtherItemVCToTopWithCurrentVC:vc];
}
#pragma mark - 更新其他Item到顶部
- (void)updateOtherItemVCToTopWithCurrentVC:(HqPageItemSuperVC *)currentVC{
    if (currentVC) {
        NSArray *subvcs = self.childViewControllers;
        
        for (HqPageItemSuperVC *vc  in subvcs) {
            if (![vc isEqual:currentVC]) {
                [vc hqScorllToTop];
            }
        }
        
        //优化
        /*
        if (self.currentPageIndex+1 < subvcs.count) {
            if (self.currentPageIndex==0) {
                HqPageItemSuperVC *lastVC = subvcs[self.currentPageIndex+1];
                [lastVC hqScorllToTop];
            }else if (self.currentPageIndex==subvcs.count-1){
                HqPageItemSuperVC *lastVC = subvcs[self.currentPageIndex-1];
                [lastVC hqScorllToTop];
            }else{
                HqPageItemSuperVC *lastVC = subvcs[self.currentPageIndex+1];
                [lastVC hqScorllToTop];
                HqPageItemSuperVC *preVC = subvcs[self.currentPageIndex-1];
                [preVC hqScorllToTop];
            }
            
        }
        */
        if (self.delegate) {
            [self.delegate mainScrollViewCanScroll];
        }
      
    }
}
#pragma mark - 更新Item的scrollview可滚动
- (void)updatePageItemCanScroll{
    NSArray *subvcs = self.childViewControllers;
    for (HqPageItemSuperVC *vc  in subvcs) {
        vc.canScroll = YES;
    }
    
    //优化
//    if (self.currentPageIndex==0) {
//        HqPageItemSuperVC *lastVC = subvcs[self.currentPageIndex+1];
//        lastVC.canScroll = YES;
//    }else if (self.currentPageIndex==subvcs.count-1){
//        HqPageItemSuperVC *lastVC = subvcs[self.currentPageIndex-1];
//        lastVC.canScroll = YES;
//    }else{
//        HqPageItemSuperVC *lastVC = subvcs[self.currentPageIndex+1];
//        lastVC.canScroll = YES;
//        HqPageItemSuperVC *preVC = subvcs[self.currentPageIndex-1];
//        preVC.canScroll = YES;
//    }
}

#pragma mark - 切换Item
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    CGPoint offset = CGPointMake(index*self.containerScrollview.bounds.size.width, 0);
    [self.containerScrollview setContentOffset:offset animated:YES];
}
- (void)refreshCurrentItemData{
    HqPageItemSuperVC *vc = self.childViewControllers[self.currentPageIndex];
    [vc refreshData];
}
#pragma mark 更新主tableview是否可滚动
- (void)notifyMainSrollViewScrollEnabled:(BOOL)scrollEnabled{
    if (self.delegate) {
        [self.delegate mainScrollViewScrollEnabled:scrollEnabled];
    }
}
#pragma mark - UIScrollViewDelegate 左右滑动subvc时，禁止主视图不可上下滑动
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     [self notifyMainSrollViewScrollEnabled:YES];
 }
 - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     [self notifyMainSrollViewScrollEnabled:NO];
 }
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat x = scrollView.contentOffset.x;
    NSInteger index = (NSInteger)x/SCREEN_WIDTH;
    if (self.currentPageIndex != index) {
        self.lastPageIndex = self.currentPageIndex;
        self.currentPageIndex = index;
        [self hqAddChildVCWithindex:index];

        if ([self.delegate respondsToSelector:@selector(pageContainerScrollViewToIndex:)] && self.delegate) {
            [self.delegate pageContainerScrollViewToIndex:index];
        }
        if ([self.delegate respondsToSelector:@selector(pageContainerScrollView:toIndex:)] && self.delegate) {
            [self.delegate pageContainerScrollView:scrollView toIndex:index];
        }
    }
}

@end
