//
//  HqCustomSegmentPageVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/20/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCustomSegmentPageVC.h"

@interface HqCustomSegmentPageVC ()

@property(nonatomic,strong) UILabel *loopView;

@end

@implementation HqCustomSegmentPageVC

- (instancetype)init{
    if (self = [super init]) {
        //重写以修改
        self.headerViewHeight = 250;
        self.sectionHeaderHeight = 50;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //配置自己头部视图
    UILabel *loopView = [[UILabel alloc] initWithFrame:CGRectZero];
    loopView.numberOfLines = 0;
    loopView.text = @"轮播或配置自己头部视图";
    loopView.textAlignment = NSTextAlignmentCenter;
    loopView.backgroundColor = HqRandomColor;
    [self.headerView addSubview:loopView];
    self.loopView = loopView;
    
    [self.sectionHeaderView addSubview:self.segment];
//    [self addRefreshUI]; //添加下拉刷新就不能要做下拉放大了，刷新自己定制
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    //这里是为了看下拉放大的效果而设置的width
    self.loopView.frame = CGRectMake(10, 0, self.view.bounds.size.width-20, self.headerViewHeight);
//    //配置自己的分段视图
    self.segment.center = self.sectionHeaderView.center;
    
}

#pragma mark - HqPageViewProtocol
- (void)pageContainerScrollViewToIndex:(NSInteger)index{
    [super pageContainerScrollViewToIndex:index];
//    NSLog(@"子类滑动index == %@",@(index));
}
- (void)mainTableviewDidScroll:(UIScrollView *)scrollView{
    [super mainTableviewDidScroll:scrollView];
    //添加处理下拉放大，则需要自定义自己的下拉刷新了 MJRefresh将会是UI错乱
    
    CGFloat y = scrollView.contentOffset.y;
    if (y<=0) {
        NSLog(@"y==%@",@(y));
        CGRect loopRect = self.loopView.frame;
        loopRect.size.height = self.headerViewHeight - y;
        loopRect.origin.y = y;
        self.loopView.frame = loopRect;
    }
}
//需要在ViewdidLoad调用 [self addRefreshUI];
- (void)refresh{
    [super refresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"end=endRefreshing=");
        [self.mainTableView.mj_header endRefreshing];
    });
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
