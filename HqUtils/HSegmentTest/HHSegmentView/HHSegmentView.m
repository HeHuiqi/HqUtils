//
//  HHSegmentView.m
//  HqUtils
//
//  Created by hehuiqi on 5/27/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HHSegmentView.h"
@interface HHSegmentView()<UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *btnItems;
@property (nonatomic,assign,readwrite) NSUInteger selectedIndex;
@property (nonatomic,strong) HHSegmentCell *firstCell;


@end


@implementation HHSegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.style = HHSegmentViewStyleDefault;
        self.normalFont = [UIFont boldSystemFontOfSize:17];
        self.selectedFont = [UIFont boldSystemFontOfSize:17];
        self.normalColor = [UIColor blackColor];
        self.selectedColor = [UIColor redColor];
        self.itemWidth = 60;
        self.indicatorViewColor = self.selectedColor;
        self.indicatorViewWidth = 40;
        self.indicatorViewHeight = 2;
        self.hideInticator = NO;
        self.hideBtoomLine = NO;
        self.bottomLineViewColor = [UIColor colorWithRed:200.0/255.0 green:199.0/255.0 blue:204.0/255.0 alpha:1.0];
//        self.bottomLineViewColor = [UIColor blueColor];
    }
    return self;
}
- (void)setStyle:(HHSegmentViewStyle)style{
    _style = style;
    if (_style == HHSegmentViewStyleCollectionView) {
        [self initColectionView];
    }else{
        [self initContentScrollview];
    }
}
- (void)initContentScrollview{
    self.btnItems = [[NSMutableArray alloc]initWithCapacity:4];
    [self addSubview:self.contentSrollView];
}
- (void)initColectionView{
    [self addSubview:self.collectionView];
    [self.collectionView addSubview:self.indicatorView];
    [self addSubview:self.bottomLineView];
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
        if (self.style == HHSegmentViewStyleCollectionView) {
            [self hqAddCollectionView];

        }else{
            [self hqAddContentScrollViewSubViews];

        }
    }
}
- (void)hqAddCollectionView{
    self.selectedIndex = 0;
    [self.collectionView reloadData];
}
- (void)hqAddContentScrollViewSubViews{
    
    for (int i = 0; i<_titles.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.normalFont;
        btn.tag = i;
        if (i == 0) {
            self.selectedIndex = 0;
            self.selectedBtn = btn;
            self.selectedBtn.selected = YES;
            self.selectedBtn.titleLabel.font = self.selectedFont;
        }
        [self.btnItems addObject:btn];
        [self.contentSrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self.contentSrollView addSubview:self.indicatorView];
    CGFloat contentWidth = _titles.count*self.itemWidth;
    if (self.style == HHSegmentViewStyleDefault) {
        if (contentWidth>self.contentSrollView.bounds.size.width) {
            CGFloat ch = self.contentSrollView.bounds.size.height;
            self.contentSrollView.contentSize = CGSizeMake(contentWidth, ch);
        }
    }
    
    [self addSubview:self.bottomLineView];
}
#pragma mark - get
- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_collectionView registerClass:HHSegmentCell.class forCellWithReuseIdentifier:HHSegmentCellID];
        _collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _collectionView;
}
- (UIScrollView *)contentSrollView{
    if (!_contentSrollView) {
        _contentSrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentSrollView.delegate = self;
        _contentSrollView.showsHorizontalScrollIndicator = NO;
    }
    return _contentSrollView;
}
- (UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = self.indicatorViewColor;
        _indicatorView.bounds = CGRectMake(0, 0, self.indicatorViewWidth, self.indicatorViewHeight);
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
#pragma mark - 改变ContentScrollView 选择下标

- (void)updateBtnState:(UIButton *)btn  isNotify:(BOOL)isNotify{
    
    if (![btn isEqual:self.selectedBtn]) {
        UIButton *lastBtn = self.selectedBtn;
        lastBtn.titleLabel.font = self.normalFont;
        lastBtn.selected = NO;
        btn.titleLabel.font = self.selectedFont;
        btn.selected = YES;
        self.selectedBtn = btn;
        self.selectedIndex = btn.tag;
        if (self.style == HHSegmentViewStyleDefault) {
            [self moveScrollView:self.contentSrollView itemView:btn];
        }
        if (!self.hideInticator) {
            [self moveIndicatorViewWithBtn:btn];
        }
        
        
        if (isNotify) {
            //通知delegate
            if (self.delegate) {
                [self.delegate hhSegmentView:self selectedIndex:btn.tag];
            }
        }
    }
}
- (void)changeIndex:(NSInteger)index{
    if (self.style == HHSegmentViewStyleCollectionView) {
        [self changeCollectionViewSelectedIndex:index];
    }else{
        [self chageContentScrollViewIndex:index];
    }
}
- (void)chageContentScrollViewIndex:(NSInteger)index{
    if (index<self.btnItems.count) {
        UIButton *btn = self.btnItems[index];
        [self updateBtnState:btn isNotify:NO];
        
    }
}
#pragma mark - 移动指示器item是Btn
- (void)moveIndicatorViewWithBtn:(UIButton *)btn{
    CGFloat y = self.bounds.size.height-self.indicatorViewHeight/2.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorView.center = CGPointMake(btn.center.x, y);
    }];
}
#pragma mark - 移动ContentScrollView 或 UICollectionView
- (void)moveScrollView:(UIScrollView *)scrollView itemView:(UIView *)view{
    
    CGFloat contentWidth = scrollView.contentSize.width;
    CGFloat scrollViewWidth = scrollView.bounds.size.width;
    CGPoint offset = scrollView.contentOffset;
    CGFloat x = CGRectGetMaxX(view.frame)+self.itemWidth;
    if (x >=scrollViewWidth) {
        CGFloat newOffsetX = x - scrollViewWidth + self.itemWidth;
        CGFloat rigthLimit = contentWidth - scrollViewWidth;
        if (newOffsetX>=rigthLimit) {
            newOffsetX = rigthLimit;
        }
        offset.x = newOffsetX;
        [scrollView setContentOffset:offset animated:YES];
    }else{
        offset.x = 0;
        [scrollView setContentOffset:offset animated:YES];
    }
}
/*
 //保留记忆
- (void)moveScroolviewWithBtn:(UIButton *)btn{
  
    CGFloat contentWidth = self.contentSrollView.contentSize.width;
    CGFloat scrollViewWidth = self.contentSrollView.bounds.size.width;
    CGPoint offset = self.contentSrollView.contentOffset;
    CGFloat x = CGRectGetMaxX(btn.frame)+self.itemWidth;
    if (x >=scrollViewWidth) {
        CGFloat newOffsetX = x - scrollViewWidth + self.itemWidth;
        CGFloat rigthLimit = contentWidth - scrollViewWidth;
        if (newOffsetX>=rigthLimit) {
            newOffsetX = rigthLimit;
        }
        offset.x = newOffsetX;
        [self.contentSrollView setContentOffset:offset animated:YES];
    }else{
        offset.x = 0;
        [self.contentSrollView setContentOffset:offset animated:YES];
    }
}
*/

#pragma mark - UICollectionViewDelegate  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HHSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HHSegmentCellID forIndexPath:indexPath];
    cell.titleLab.text = self.titles[indexPath.row];
    UIFont *titleFont = self.normalFont;
    UIColor *titleColor = self.normalColor;
    if (indexPath.row == 0) {
        self.firstCell = cell;
    }
    if (indexPath.row == self.selectedIndex) {
        titleFont = self.selectedFont;
        titleColor = self.selectedColor;
    }
    cell.titleLab.font = titleFont;
    cell.titleLab.textColor = titleColor;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemH = collectionView.bounds.size.height;
    return CGSizeMake(self.itemWidth, itemH);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self changeCollectionViewSelectedIndex:indexPath.row];
    if (self.delegate) {
        [self.delegate hhSegmentView:self selectedIndex:self.selectedIndex];
    }
}
#pragma mark - 改变CollectionView 选择下标
- (void)changeCollectionViewSelectedIndex:(NSInteger)index{
    if (index<self.titles.count) {
        self.selectedIndex = index;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        HHSegmentCell *cell = (HHSegmentCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [self moveCollectionIndicatorWithView:cell index:index];
        [self moveScrollView:self.collectionView itemView:cell];
        [self.collectionView reloadData];
    }
}
#pragma mark - 移动指示器 item 是Cell
- (void)moveCollectionIndicatorWithView:(UIView *)view index:(NSInteger)index{
    CGPoint indicatorCenter = self.indicatorView.center;
    /*
    if (view == nil) {
        indicatorCenter.x = self.itemWidth*index+self.itemWidth/2.0;
    }else{
        indicatorCenter.x = view.center.x;
    }
    */
    indicatorCenter.x = self.itemWidth*index+self.itemWidth/2.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorView.center = indicatorCenter;
    }];
}
#pragma mark - layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.style == HHSegmentViewStyleCollectionView) {
        [self hqLayoutCollectionView];
        
    }else{
        [self hqLayoutContentSrollView];
    }
    
}
- (void)hqLayoutCollectionView{
    CGFloat vH = self.bounds.size.height;
    self.collectionView.frame = self.bounds;
    CGFloat y = vH-self.indicatorViewHeight/2.0;
    self.indicatorView.center = CGPointMake(self.itemWidth/2.0, y);
    
    CGFloat lineH = 1.0/[UIScreen mainScreen].scale;
    CGFloat lineY = vH - lineH;
    self.bottomLineView.frame = CGRectMake(0, lineY, self.bounds.size.width, lineH);
    self.bottomLineView.backgroundColor = self.bottomLineViewColor;
}
- (void)hqLayoutContentSrollView{
    CGFloat btnH = self.bounds.size.height;
    
    NSArray *subviews = self.btnItems;
    CGFloat btnW = self.itemWidth; //HHSegmentViewStyleDefault
    if (self.style == HHSegmentViewStyleEqualSeparate) {
        btnW = self.bounds.size.width/self.btnItems.count;
    }
    for (int i = 0; i<subviews.count; i++) {
        UIButton *btn = subviews[i];
        btn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        if (i == 0) {
            CGFloat y = btnH-self.indicatorViewHeight/2.0;
            self.indicatorView.center = CGPointMake(btn.center.x, y);
        }
    }
    
    CGFloat lineH = 1.0/[UIScreen mainScreen].scale;
    CGFloat lineY = btnH - lineH;
    self.bottomLineView.frame = CGRectMake(0, lineY, self.bounds.size.width, lineH);
}

@end
