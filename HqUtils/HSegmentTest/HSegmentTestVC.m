//
//  HSegmentTestVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/27/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HSegmentTestVC.h"
#import "HHSegmentView.h"

#import "HHCategoryView.h"
#import "HHPullDownContentView.h"


@interface HSegmentTestVC ()<
UIScrollViewDelegate,
HHCategoryViewDelegate,
HHPullDownContentViewDelegate>

@property (nonatomic,strong) HHSegmentView *sgv;

@property(nonatomic,strong) HHCategoryView *categoryView;
@property(nonatomic,strong) UIScrollView *pageScrollView;

@property(nonatomic,strong) HHPullDownContentView *downContentView;


@end

@implementation HSegmentTestVC

- (HHCategoryView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[HHCategoryView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, self.view.bounds.size.width, 40)];
        _categoryView.delegate = self;
    }
    return _categoryView;
}
- (HHPullDownContentView *)downContentView{
    if (!_downContentView) {
        CGFloat y = self.navBarHeight+CGRectGetHeight(self.categoryView.frame);
        CGFloat h = self.view.bounds.size.height - y;
        _downContentView = [[HHPullDownContentView alloc] initWithFrame:CGRectMake(0,y , self.view.bounds.size.width, h)];
        _downContentView.delegate = self;
        _downContentView.hidden = YES;
        _downContentView.titles = @[@"item1",@"item2",@"item3",@"item4"];
    }
    return _downContentView;
}
- (UIScrollView *)pageScrollView{
    if (!_pageScrollView) {
        CGFloat y = self.navBarHeight + 40;
        CGFloat h = self.view.bounds.size.height - y;
        _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, h)];
        _pageScrollView.delegate = self;
        _pageScrollView.pagingEnabled = YES;
    }
    return _pageScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)testCatergoryView{
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.pageScrollView];
    [self.view addSubview:self.downContentView];
    
    
    NSMutableArray *titles = @[].mutableCopy;
    NSInteger count = 10;
    
    self.categoryView.itemWidth = 70;
//    self.categoryView.indicatorSize = CGSizeMake(10, 2);
//    self.categoryView.isZoom = YES;
//    self.categoryView.showArrow = YES;
    
    for (NSInteger i = 0; i<count; i++) {
        NSString *title = [NSString stringWithFormat:@"标题-%@",@(i)];
        [titles addObject:title];
    }
    self.categoryView.titles = titles;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.categoryView initSelectedIndex:5];
    });
    
    for (NSInteger i = 0; i<count; i++) {
        CGFloat x = i*self.view.bounds.size.width;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, self.view.bounds.size.width, self.pageScrollView.bounds.size.height)];
        lab.backgroundColor = HqRandomColor;
        lab.text = @(i).stringValue;
        lab.font = [UIFont boldSystemFontOfSize:40];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.pageScrollView addSubview:lab];
    }
    self.pageScrollView.contentSize = CGSizeMake(self.view.bounds.size.width*count, self.pageScrollView.bounds.size.height);
}
- (void)initView{
    [self testCatergoryView];
}

#pragma mark - HHCategoryViewDelegate
- (void)hhCategoryView:(HHCategoryView *)categoryView isOpenDown:(BOOL)isOpenDown{
    
    self.downContentView.hidden = !isOpenDown;
}
- (void)hhCategoryView:(HHCategoryView *)categoryView selectedIndex:(NSInteger)selectedIndex{
    CGFloat offsetX = selectedIndex*self.view.bounds.size.width;
    CGPoint offset = self.pageScrollView.contentOffset;
    offset.x = offsetX;
    [self.pageScrollView setContentOffset:offset animated:NO];
}
#pragma mark - HHPullDownContentViewDelegate
- (void)hhPullDownContentView:(HHPullDownContentView *)view selectedItem:(id)item{
    [self.categoryView reloadFirstItemContent:item];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = (NSInteger)offsetX/self.view.bounds.size.width;
        NSLog(@"index==%@",@(index));
    self.categoryView.selectedIndex = index;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = (NSInteger)offsetX/self.view.bounds.size.width;
        NSLog(@"index==%@",@(index));
    self.categoryView.selectedIndex = index;
}


@end
