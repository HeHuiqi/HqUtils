//
//  HqPageContainerVC.h
//  HqUtils
//
//  Created by hehuiqi on 5/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqPageViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface HqPageContainerVC : UIViewController<UIScrollViewDelegate>

@property (nonatomic,weak) id<HqPageViewProtocol> delegate;

@property (nonatomic,strong) UIScrollView *containerScrollview;
@property (nonatomic,assign) NSUInteger currentPageIndex;//当前选中Item index
@property (nonatomic,assign) NSUInteger lastPageIndex;//上一个选中Item index

@property (nonatomic,strong) NSArray *pageItems;//所有的Item vc

//添加子vc
- (void)hqAddChildVCWithindex:(NSInteger)index;
#pragma mark - 更新Item的scrollview可滚动
- (void)updatePageItemCanScroll;
#pragma mark - 切换Item
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (void)refreshCurrentItemData;

@end

NS_ASSUME_NONNULL_END
