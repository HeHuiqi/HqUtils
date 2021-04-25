//
//  HHCategoryView.h
//  HqUtils
//
//  Created by hehuiqi on 2021/3/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqCategoryItemDefaultCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HHCategoryViewDelegate;
@interface HHCategoryView : UIView

@property(nonatomic,weak) id<HHCategoryViewDelegate> delegate;
@property(nonatomic,assign) CGFloat itemWidth;
@property(nonatomic,assign) NSUInteger selectedIndex;
@property(nonatomic,strong) NSArray *items;

@property(nonatomic,assign) CGFloat itemSpace;
@property(nonatomic,assign) UIEdgeInsets contentInset;
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,assign) CGSize indicatorSize;
@property(nonatomic,strong) UIView *indicatorView;

@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,assign) BOOL isZoom;
@property(nonatomic,assign) BOOL showArrow;

- (void)initSelectedIndex:(NSUInteger)index;
- (void)reloadFirstItemContent:(id)content;

@end

@protocol HHCategoryViewDelegate <NSObject>

@optional
- (void)hhCategoryView:(HHCategoryView *)categoryView selectedIndex:(NSInteger)selectedIndex;
- (void)hhCategoryView:(HHCategoryView *)categoryView isOpenDown:(BOOL)isOpenDown;

@end

NS_ASSUME_NONNULL_END
