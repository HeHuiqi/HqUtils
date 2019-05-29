//
//  HqCustomSegmentPageVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/20/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCustomSegmentPageVC.h"

@interface HqCustomSegmentPageVC ()

@end

@implementation HqCustomSegmentPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerViewHeight = 300;
    self.sectionHeaderHeight = 70;
    //配置自己头部视图
    UILabel *loopView = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.headerView.bounds.size.width-20, 100)];
    loopView.numberOfLines = 0;
    loopView.text = @"轮播或配置自己头部视图";
    [self.headerView addSubview:loopView];
    
    //配置自己的分段视图
    CGPoint center = self.segment.center;
    center.y = self.sectionHeaderHeight/2.0;
    self.segment.center = center;
    [self.sectionHeaderView addSubview:self.segment];

}
#pragma mark - HqPageViewProtocol
- (void)pageContainerScrollViewToIndex:(NSInteger)index{
    [super pageContainerScrollViewToIndex:index];
    NSLog(@"子类滑动index == %@",@(index));
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
