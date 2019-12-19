//
//  HqSubContainerVC.m
//  HqUtils
//
//  Created by hehuiqi on 2019/11/29.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqSubContainerVC.h"
#import "HqContainerVC.h"

@interface HqSubContainerVC ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIView *segmentHeaderView;
@property(nonatomic,strong) UIScrollView *containerScrollView;
@property(nonatomic,strong) HqSubChildVC *subChildVC1;
@property(nonatomic,strong) HqSubChildVC *subChildVC2;

@end

@implementation HqSubContainerVC
- (UIView *)segmentHeaderView{
    if (!_segmentHeaderView) {
        _segmentHeaderView = [[UIView alloc] init];
        _segmentHeaderView.backgroundColor = [UIColor redColor];
    }
    return _segmentHeaderView;
}
- (UIScrollView *)containerScrollView{
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc] init];
        _containerScrollView.delegate = self;
        _containerScrollView.bounces = NO;
        _containerScrollView.pagingEnabled = YES;
    }
    return _containerScrollView;
}
- (HqSubChildVC *)subChildVC1{
    if (!_subChildVC1) {
        _subChildVC1 = [[HqSubChildVC alloc] init];
        _subChildVC1.view.backgroundColor = [UIColor redColor];
    }
    return _subChildVC1;
}
- (HqSubChildVC *)subChildVC2{
    if (!_subChildVC2) {
        _subChildVC2 = [[HqSubChildVC alloc] init];
        _subChildVC2.view.backgroundColor = [UIColor blueColor];
    }
    return _subChildVC2;
}
- (void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
    for (HqSubChildVC *vc  in self.childViewControllers) {
        vc.canScroll = canScroll;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segmentHeaderView];
    [self.view addSubview:self.containerScrollView];
    [self.segmentHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    CGFloat contentH = SCREEN_HEIGHT-40-64;
    CGFloat contentW = SCREEN_WIDTH;
    [self.containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.segmentHeaderView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(contentW, contentH));
    }];
    self.containerScrollView.contentSize = CGSizeMake(contentW*2, contentH);
    self.containerScrollView.backgroundColor = [UIColor yellowColor];
    
    [self addChildViewController:self.subChildVC1];
    [self.containerScrollView addSubview:self.subChildVC1.view];
    [self.subChildVC1.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerScrollView).offset(0);
        make.top.equalTo(self.containerScrollView).offset(0);
        make.size.mas_equalTo(CGSizeMake(contentW, contentH));
    }];

    [self addChildViewController:self.subChildVC2];
    [self.containerScrollView addSubview:self.subChildVC2.view];
    [self.subChildVC2.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerScrollView).offset(contentW);
        make.top.equalTo(self.containerScrollView).offset(0);
        make.size.mas_equalTo(CGSizeMake(contentW, contentH));
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    HqContainerVC *vc = (HqContainerVC *)self.parentViewController;
    vc.tableView.scrollEnabled = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    HqContainerVC *vc = (HqContainerVC *)self.parentViewController;
    vc.tableView.scrollEnabled = YES;
    
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
