//
//  HqRecommendTopSegmentView.h
//  LC
//
//  Created by hehuiqi on 2020/1/2.
//  Copyright © 2020 youfu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HqRecommendTopSegmentViewStype) {
    HqRecommendTopSegmentViewStypeDefault,//Items默认在srollView向后追加
    HqRecommendTopSegmentViewStypeCustomDefault,//Items默认在srollView向后追加,按钮宽度随文字宽度变化
    HqRecommendTopSegmentViewStypeEqualSeparate,//Items等分srollView添加在srollView
};
NS_ASSUME_NONNULL_BEGIN


@protocol HqRecommendTopSegmentViewDelegate;
@interface HqRecommendTopSegmentView : UIView

@property (nonatomic,weak) id<HqRecommendTopSegmentViewDelegate> delegate;

@property (nonatomic,assign) HqRecommendTopSegmentViewStype style;//样式需先设置,默认为HqRecommendTopSegmentViewStypeDefault

@property (nonatomic,assign) CGFloat conentleftRightInset;//scrollview
@property (nonatomic,assign) CGFloat itemPace;//按钮间距

@property (nonatomic,strong) UIScrollView *contentSrollView;
@property (nonatomic,strong) NSArray *titles;


@property (nonatomic,assign) UIButton *selectedBtn;
@property (nonatomic,assign) CGFloat btnWidth;
@property (nonatomic,assign,readonly) NSUInteger selectedIndex;

@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *selectedColor;
@property (nonatomic,strong) UIFont *normalFont;
@property (nonatomic,strong) UIFont *selectedFont;

@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) UIColor *indicatorViewColor;
@property (nonatomic,assign) CGFloat indicatorViewWidth;
@property (nonatomic,assign) CGFloat indicatorViewHeight;
@property (nonatomic,assign) BOOL hideInticator;

@property (nonatomic,strong) UIView *bottomLineView;
@property (nonatomic,strong) UIColor *bottomLineViewColor;
@property (nonatomic,assign) BOOL hideBtoomLine;

//@property (nonatomic,strong) UIImageView *badgeImgView;
//@property (nonatomic,assign) NSInteger bagdgeIndx;


@property (nonatomic,strong) UIView *badgeRedPointView;
@property (nonatomic,assign) NSInteger badgeRedPointIndex;

@property (nonatomic,strong) UIImageView *badgeNewIcon;//newIcon
@property (nonatomic,assign) NSInteger badgeNewIconIndex;//newIcon index



- (void)changeIndex:(NSInteger)index;

- (void)showBadgeNewIconWithIndex:(NSInteger)index;
- (void)removeBadgeNewIconWithIndex:(NSInteger)index;

- (void)showBadgeRedPointWithIndex:(NSInteger)index;
- (void)removeBadgeRedPointWithIndex:(NSInteger)index;


@end


@protocol HqRecommendTopSegmentViewDelegate <NSObject>

@optional
- (void)HqRecommendTopSegmentView:(HqRecommendTopSegmentView *)segmentView selectedIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

