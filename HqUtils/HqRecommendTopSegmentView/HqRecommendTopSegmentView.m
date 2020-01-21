//
//  HqRecommendTopSegmentView.m
//  LC
//
//  Created by hehuiqi on 2020/1/2.
//  Copyright © 2020 youfu. All rights reserved.
//

#import "HqRecommendTopSegmentView.h"

@interface HqRecommendTopSegmentView()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *btnItems;
@property (nonatomic,strong) NSMutableArray *btnItemWidths;
@property (nonatomic,assign) CGFloat allbtnWidth;


@property (nonatomic,assign,readwrite) NSUInteger selectedIndex;


@end


@implementation HqRecommendTopSegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectedIndex = 0;
        self.style = HqRecommendTopSegmentViewStypeDefault;
        self.badgeNewIconIndex = -1;
        self.itemPace = 25;
        self.conentleftRightInset = 15;
        self.normalFont = [UIFont boldSystemFontOfSize:12];
        self.selectedFont = [UIFont boldSystemFontOfSize:12];
        self.normalColor = [UIColor lightGrayColor];
        self.selectedColor = [UIColor blackColor];
        self.btnWidth = 65;
        self.indicatorViewColor = [UIColor redColor];
        self.indicatorViewWidth = 40;
        self.indicatorViewHeight = 2;
        self.hideInticator = NO;
        self.hideBtoomLine = NO;
        self.badgeNewIconIndex = -1;
        [self setup];
    }
    return self;
}
- (void)setNormalFont:(UIFont *)normalFont{
    _normalFont = normalFont;
    self.titles = self.titles;
}
- (void)setSelectedFont:(UIFont *)selectedFont{
    _selectedFont = selectedFont;
    self.titles = self.titles;
}

- (void)showBadgeNewIconWithIndex:(NSInteger)index{
    [self.contentSrollView addSubview:self.badgeNewIcon];
    self.badgeNewIconIndex = index;
}
- (void)removeBadgeNewIconWithIndex:(NSInteger)index{
    [self.badgeNewIcon removeFromSuperview];
}


- (UIView *)badgeRedPointView{
    if (!_badgeRedPointView) {
        _badgeRedPointView = [[UIView alloc] init];
        _badgeRedPointView.bounds = CGRectMake(0, 0, 8 , 8);
    }
    return _badgeRedPointView;
}
- (void)showBadgeRedPointWithIndex:(NSInteger)index{
    [self.contentSrollView addSubview:self.badgeRedPointView];
    NSLog(@"badgeRedPointIndex==%@",@(index));
    self.badgeRedPointIndex = index;
    [self setNeedsLayout];
}

- (void)removeBadgeRedPointWithIndex:(NSInteger)index{
    [self.badgeRedPointView removeFromSuperview];

}
- (void)setup{
   
    self.btnItems = [[NSMutableArray alloc]initWithCapacity:4];
    self.btnItemWidths = [[NSMutableArray alloc]initWithCapacity:4];
    [self addSubview:self.contentSrollView];
}
#pragma mark  - set
- (void)setHideBtoomLine:(BOOL)hideBtoomLine{
    _hideBtoomLine = hideBtoomLine;
    self.bottomLineView.hidden = _hideBtoomLine;
}
- (void)setHideInticator:(BOOL)hideInticator{
    _hideInticator = hideInticator;
    self.indicatorView.hidden = _hideInticator;
}
- (void)setIndicatorViewWidth:(CGFloat)indicatorViewWidth{
    _indicatorViewWidth = indicatorViewWidth;
    if (_indicatorViewWidth>0) {
        CGRect bounds = self.indicatorView.bounds;
        bounds.size.width = _indicatorViewWidth;
        self.indicatorView.bounds = bounds;
    }
   
}
- (void)setBottomLineViewColor:(UIColor *)bottomLineViewColor{
    _bottomLineViewColor = bottomLineViewColor;
    if (_bottomLineViewColor) {
        self.bottomLineView.backgroundColor = _bottomLineViewColor;
    }
}
- (void)setIndicatorViewHeight:(CGFloat)indicatorViewHeight{
    _indicatorViewHeight = indicatorViewHeight;
    if (_indicatorViewHeight>0) {
        CGRect bounds = self.indicatorView.bounds;
        bounds.size.height = _indicatorViewHeight;
        self.indicatorView.bounds = bounds;
    }
}
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (_titles.count>0) {
        self.allbtnWidth = 0;
        [self.btnItemWidths removeAllObjects];
        [self.btnItems removeAllObjects];
        for (UIView *view  in self.contentSrollView.subviews) {
            [view removeFromSuperview];
        }
        for (int i = 0; i<titles.count; i ++) {
            UIButton *btn = [[UIButton alloc] init];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
            [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"lc_red_btn_bg"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"lc_red_btn_bg"] forState:UIControlStateSelected];
            btn.titleLabel.font = self.normalFont;
            btn.tag = i;
            if (i == self.selectedIndex) {
                self.selectedIndex = i;
                self.selectedBtn = btn;
                self.selectedBtn.selected = YES;
                self.selectedBtn.titleLabel.font = self.selectedFont;
            }
            CGFloat btnW = 0;
            self.allbtnWidth = self.allbtnWidth+btnW;
            [self.btnItemWidths addObject:@(btnW)];
            [self.btnItems addObject:btn];
            [self.contentSrollView addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [self.contentSrollView addSubview:self.indicatorView];
        /*
        CGFloat contentWidth = _titles.count*self.btnWidth;
        if (self.style == HqRecommendTopSegmentViewStypeDefault) {
            if (contentWidth>self.contentSrollView.bounds.size.width) {
                CGFloat ch = self.contentSrollView.bounds.size.height;
                self.contentSrollView.contentSize = CGSizeMake(contentWidth, ch);
            }
        }
        */
        [self dealScrollViewContentSize];
       
        [self addSubview:self.bottomLineView];
    }
}
- (void)dealScrollViewContentSize{
    
    self.contentSrollView.contentInset = UIEdgeInsetsMake(0, self.conentleftRightInset, 0, self.conentleftRightInset);
//    if (self.style == HqRecommendTopSegmentViewStypeDefault) {
//        CGFloat contentWidth = _titles.count*self.btnWidth;
//        if (contentWidth>self.contentSrollView.bounds.size.width) {
//            CGFloat ch = self.contentSrollView.bounds.size.height;
//            self.contentSrollView.contentSize = CGSizeMake(contentWidth, ch);
//        }
//    }
    if (self.style == HqRecommendTopSegmentViewStypeDefault) {
        
        CGFloat contentWidth = (_titles.count+1)*self.itemPace + self.allbtnWidth;
        if (contentWidth>self.contentSrollView.bounds.size.width) {
            CGFloat ch = self.contentSrollView.bounds.size.height;
            self.contentSrollView.contentSize = CGSizeMake(contentWidth, ch);
        }
    }
}
#pragma mark - get
- (UIScrollView *)contentSrollView{
    if (!_contentSrollView) {
        _contentSrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentSrollView.delegate = self;
        _contentSrollView.showsHorizontalScrollIndicator = NO;
        _contentSrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentSrollView;
}
- (UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = self.indicatorViewColor;
        _indicatorView.bounds = CGRectMake(0, 9, self.indicatorViewWidth, self.indicatorViewHeight);
    }
    return _indicatorView;
}
- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = self.bottomLineViewColor;
    }
    return _bottomLineView;
}
#pragma mark - btnClick
- (void)btnClick:(UIButton *)btn{
    
    [self updateBtnState:btn isNotify:YES];
}
- (void)updateBtnState:(UIButton *)btn  isNotify:(BOOL)isNotify{
    
    if (![btn isEqual:self.selectedBtn]) {
        UIButton *lastBtn = self.selectedBtn;
        lastBtn.titleLabel.font = self.normalFont;
        lastBtn.selected = NO;
        btn.titleLabel.font = self.selectedFont;
        btn.selected = YES;
        self.selectedBtn = btn;
        self.selectedIndex = btn.tag;
        if (self.style == HqRecommendTopSegmentViewStypeDefault) {
            [self moveScroolviewWithBtn:btn];
        }
        if (!self.hideInticator) {
            [self moveIndicatorViewWithBtn:btn];
        }
        
        
        if (isNotify) {
            //通知delegate
            if (self.delegate) {
                [self.delegate HqRecommendTopSegmentView:self selectedIndex:btn.tag];
            }
        }
    }
}
- (void)changeIndex:(NSInteger)index{
    if (index<self.btnItems.count) {
        UIButton *btn = self.btnItems[index];
        [self updateBtnState:btn isNotify:NO];
    }
}
- (void)moveIndicatorViewWithBtn:(UIButton *)btn{
    CGFloat y = self.bounds.size.height-self.indicatorViewHeight/2.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorView.center = CGPointMake(btn.center.x, y);
    }];
}
- (void)moveScroolviewWithBtn:(UIButton *)btn{
    NSInteger index = btn.tag+1;
    CGFloat nextBtnWidth = self.btnWidth;
    if (self.style == HqRecommendTopSegmentViewStypeDefault) {
        if (index<self.btnItemWidths.count) {
            nextBtnWidth = self.itemPace;
        }
    }
  
   
    CGFloat contentWidth = self.contentSrollView.contentSize.width;
    CGFloat scrollViewWidth = self.contentSrollView.bounds.size.width+self.conentleftRightInset*2;
    if (contentWidth<=scrollViewWidth) {
        return;
    }
    CGPoint offset = self.contentSrollView.contentOffset;
    CGFloat x = CGRectGetMinX(btn.frame)+nextBtnWidth;
    if (x >=scrollViewWidth/2.0) {
        CGFloat newOffsetX = x - (scrollViewWidth/2.0) + nextBtnWidth;
        CGFloat rigthLimit = contentWidth - scrollViewWidth;
        if (newOffsetX>=rigthLimit) {
            newOffsetX = rigthLimit;
        }
        offset.x = newOffsetX;
        [self.contentSrollView setContentOffset:offset animated:YES];
    }else{
        offset.x = -self.conentleftRightInset;
        [self.contentSrollView setContentOffset:offset animated:YES];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentSrollView.frame = self.bounds;
    CGSize contentSize =  self.contentSrollView.contentSize;
    contentSize.height = self.bounds.size.height;
    self.contentSrollView.contentSize = contentSize;
    NSArray *subviews = self.btnItems;
    CGFloat btnW = 0; //HqRecommendTopSegmentViewStypeDefault
    
    if (self.style == HqRecommendTopSegmentViewStypeEqualSeparate) {
        btnW = self.bounds.size.width/self.btnItems.count;
    }
    
    CGFloat btnH = self.bounds.size.height;
    CGFloat customX = 0;

    for (int i = 0; i<subviews.count; i++) {
        UIButton *btn = subviews[i];
        
        if (self.style == HqRecommendTopSegmentViewStypeDefault) {
            NSNumber *titleWidth = self.btnItemWidths[i];
            CGFloat btnw = titleWidth.floatValue;
//            NSLog(@"i == %@,btw=%@,self.itemPace=%@",@(i),@(btnw),@(self.itemPace));

//            NSLog(@"xxxx == %@",@(customX));
            btn.frame = CGRectMake(customX, 0, btnw, btnH);
//            btn.backgroundColor = HqRandomColor;
            customX = CGRectGetMaxX(btn.frame)+self.itemPace;
        }else{
            btn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        }
        if (i == self.selectedIndex) {
            CGFloat y = btnH-self.indicatorViewHeight/2.0;
            self.indicatorView.center = CGPointMake(btn.center.x, y);
        }
        if (i == self.badgeNewIconIndex) {
            CGFloat maxX = CGRectGetMaxX(btn.frame);
            CGFloat centerX = maxX+CGRectGetWidth(self.badgeNewIcon.bounds)/2.0;
            CGFloat centerY = 15;
            self.badgeNewIcon.center = CGPointMake(centerX,centerY);
        }
        
        if (i == self.badgeRedPointIndex) {
            CGFloat maxX = CGRectGetMaxX(btn.frame);
            CGFloat centerX = maxX+CGRectGetWidth(self.badgeRedPointView.bounds)/2.0;
            CGFloat centerY = 15;
            self.badgeRedPointView.center = CGPointMake(centerX,centerY);
        }
    }
    CGFloat lineH = 1.0/[UIScreen mainScreen].scale;
    CGFloat lineY = btnH - lineH;
    self.bottomLineView.frame = CGRectMake(0, lineY, self.bounds.size.width, lineH);
}


@end
