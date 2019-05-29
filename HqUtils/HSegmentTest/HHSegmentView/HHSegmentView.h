//
//  HHSegmentView.h
//  HqUtils
//
//  Created by hehuiqi on 5/27/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSegmentCell.h"

typedef NS_ENUM(NSInteger,HHSegmentViewStyle) {
    HHSegmentViewStyleDefault,//Items默认在srollView向后追加
    HHSegmentViewStyleEqualSeparate,//Items等分srollView添加在srollView
    HHSegmentViewStyleCollectionView,//Items等分srollView添加在srollView

};
NS_ASSUME_NONNULL_BEGIN


@protocol HHSegmentViewDelegate;
@interface HHSegmentView : UIView

@property (nonatomic,weak) id<HHSegmentViewDelegate> delegate;

@property (nonatomic,assign) HHSegmentViewStyle style;//样式需先设置,默认为HQSegmentViewStyleDefault

@property (nonatomic,assign) CGFloat itemWidth;//item宽度默认60,要修改初始化后先设置


@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;


@property (nonatomic,strong) UIScrollView *contentSrollView;//Button Item 容器
@property (nonatomic,strong) NSArray *titles;//所有item标题

@property (nonatomic,assign) UIButton *selectedBtn;//选中btn
@property (nonatomic,assign,readonly) NSUInteger selectedIndex;//当前选择下标

@property (nonatomic,strong) UIColor *normalColor;//正常颜色
@property (nonatomic,strong) UIColor *selectedColor;//选择颜色
@property (nonatomic,strong) UIFont *normalFont;//正常字体
@property (nonatomic,strong) UIFont *selectedFont;//选择中字体

@property (nonatomic,strong) UIView *indicatorView;//指示器
@property (nonatomic,strong) UIColor *indicatorViewColor;
@property (nonatomic,assign) CGFloat indicatorViewWidth;//指示器宽度
@property (nonatomic,assign) CGFloat indicatorViewHeight;//指示器高度
@property (nonatomic,assign) BOOL hideInticator;//是否隐藏指示器

@property (nonatomic,strong) UIView *bottomLineView;//底部线条
@property (nonatomic,strong) UIColor *bottomLineViewColor;
@property (nonatomic,assign) BOOL hideBtoomLine;//是否隐藏底部线条


- (void)changeIndex:(NSInteger)index;

@end


@protocol HHSegmentViewDelegate <NSObject>

@optional
- (void)hhSegmentView:(HHSegmentView *)segmentView selectedIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
