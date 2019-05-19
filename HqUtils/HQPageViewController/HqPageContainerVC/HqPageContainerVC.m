//
//  HqPageContainerVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPageContainerVC.h"

#import "HQPage1VC.h"
#import "HQPage2VC.h"
#import "HqPage3VC.h"

@interface HqPageContainerVC ()<HqPageViewProtocol>


@property(nonatomic,strong) HQPage1VC *pageV1;
@property(nonatomic,strong) HQPage2VC *pageV2;
@property(nonatomic,strong) HqPage3VC *pageV3;

@end

@implementation HqPageContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPageIndex = 0;
    [self.view addSubview:self.containerScrollview];
//    self.pageItems = @[self.pageV1,self.pageV2,self.pageV3];
//    
//    [self hqAddChildVCWithindex:self.currentPageIndex];
    
}
- (void)hqAddChildVCWithindex:(NSInteger)index{
    NSArray *subvc  = self.childViewControllers;
    CGFloat height = self.containerScrollview.bounds.size.height;
    CGFloat width  = self.containerScrollview.bounds.size.width;
    UIViewController *vc = self.pageItems[index];
    if (![subvc containsObject:vc]) {
        [self addChildViewController:vc];
        [self.containerScrollview addSubview:vc.view];
        vc.view.frame = CGRectMake(width*index, 0, width, height);
    }
}
- (void)setPageItems:(NSArray *)pageItems{
    _pageItems = pageItems;
    if (_pageItems.count>0) {
        CGFloat height = self.containerScrollview.bounds.size.height;
        CGFloat width  = self.containerScrollview.bounds.size.width;
        _containerScrollview.contentSize = CGSizeMake(width*_pageItems.count, height);
        for (HqPageItemSuperVC *vc  in _pageItems) {
            vc.delegate = self;
        }
    }
}

- (UIScrollView *)containerScrollview{
    if (!_containerScrollview) {
        CGFloat height = SCREEN_HEIGHT-88;
        
        _containerScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        _containerScrollview.contentSize = CGSizeMake(SCREEN_WIDTH*3, height);
        _containerScrollview.pagingEnabled = YES;
        _containerScrollview.delegate = self;
    }
    return _containerScrollview;
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

#pragma mark - HqPageViewProtocol
- (void)hqPageItemVC:(HqPageItemSuperVC *)vc scrollViewOffetY:(CGFloat)offsetY{
    [self updateOtherItemVCToTopWithCurrentVC:vc];
}
#pragma mark - 更新其他Item到顶部
- (void)updateOtherItemVCToTopWithCurrentVC:(HqPageItemSuperVC *)currentVC{
    if (currentVC) {
        NSArray *subvcs = self.childViewControllers;
        /*
        for (HqPageItemSuperVC *vc  in subvcs) {
            if (![vc isEqual:currentVC]) {
                [vc hqScorllToTop];
            }
        }
        */
        
        
        //优化
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
    CGPoint offset = CGPointMake(index*SCREEN_WIDTH, 0);
    [self.containerScrollview setContentOffset:offset animated:animated];
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
#pragma mark - UIScrollViewDelegate
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     [self notifyMainSrollViewScrollEnabled:YES];
 }
 - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     [self notifyMainSrollViewScrollEnabled:NO];
 }
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat x = scrollView.contentOffset.x;
    NSInteger index = (NSInteger)x/SCREEN_WIDTH;
    if (self.currentPageIndex !=index) {
        self.lastPageIndex = self.currentPageIndex;
        self.currentPageIndex = index;
        [self hqAddChildVCWithindex:index];
        if (self.delegate) {
            [self.delegate pageContainerScrollViewToIndex:index];
        }
    }
//    self.currentPageIndex = index;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
