//
//  HqPageViewProtocol.h
//  HqUtils
//
//  Created by hehuiqi on 4/22/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HqPageItemSuperVC;
typedef void(^HqScrollViewOffetYBlock)(CGFloat offsetY);

typedef void(^HqPageItemScrollViewOffetYBlock)(HqPageItemSuperVC * _Nonnull vc,CGFloat offsetY);


NS_ASSUME_NONNULL_BEGIN

@protocol HqPageViewProtocol <NSObject>

@optional
//由HqPageItemViewSuperVC实现
- (void)hqPageItemVC:(HqPageItemSuperVC *)vc scrollViewOffetY:(CGFloat)offsetY;
// 由HqPageContainerVC 实现
- (void)mainScrollViewCanScroll;
- (void)mainScrollViewScrollEnabled:(BOOL)scrollEnabled;

//HqPageContainer
- (void)pageContainerScrollViewToIndex:(NSInteger)index;
- (void)pageContainerScrollView:(UIScrollView *)scrollView toIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
