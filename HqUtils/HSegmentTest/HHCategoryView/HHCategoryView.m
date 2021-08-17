//
//  HHCategoryView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/3/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HHCategoryView.h"

@interface HHCategoryView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation HHCategoryView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.indicatorSize = CGSizeMake(30, 2);
        [self setup];
    }
    return self;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:HqCategoryItemDefaultCell.class forCellWithReuseIdentifier:HqCategoryItemDefaultCellId];
        
    }
    return _collectionView;
}
- (void)setContentInset:(UIEdgeInsets)contentInset{
    _contentInset = contentInset;
    self.contentInset = contentInset;
}
- (void)setIndicatorSize:(CGSize)indicatorSize{
    _indicatorSize = indicatorSize;
    if (indicatorSize.width > 0 && indicatorSize.height > 0) {
        CGRect frame = self.indicatorView.frame;
        frame.size = indicatorSize;
        self.indicatorView.frame = frame;
    }
}
- (UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        CGFloat y = self.bounds.size.height - self.indicatorSize.height;
        _indicatorView.frame = CGRectMake(0,  y, self.indicatorSize.width, self.indicatorSize.height);
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}
- (void)setup{
    [self addSubview:self.collectionView];
    [self.collectionView addSubview:self.indicatorView];

    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    
}
- (CGFloat)itemSpace{
    if (_itemSpace == 0) {
        return CGFLOAT_MIN;
    }
    return _itemSpace;
}
- (void)setItems:(NSArray *)items{
    _items = items;
    if (items) {
        [self.collectionView reloadData];
    }
}
//指定宽度获取文本高度
- (CGFloat )getTextWidthWithString:(NSString *)string font:(UIFont *)font{
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(0, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
    return contentSize.width;
}
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (_titles) {
        CGFloat x = 0;
        NSMutableArray *items = @[].mutableCopy;
        for (NSInteger i = 0; i<titles.count; i++) {
            HqCategoryItem *item = [[HqCategoryItem alloc] init];
            BOOL isFirst = (i==0);
            item.selected = isFirst;
            if (self.isZoom) {
                item.isZoom = isFirst;
            }
            if (self.showArrow) {
                item.showArrow = isFirst;
            }
            item.title = titles[i];
            CGFloat itemW = self.itemWidth;
            if (self.itemWidth <= 0) {
                UIFont *font = [UIFont boldSystemFontOfSize:kZoomValue(15)];
                itemW = [self getTextWidthWithString:item.title font:font]+10;
            }
            item.cellWidth = itemW;
            item.cellFrame = CGRectMake(x, 0, item.cellWidth, self.bounds.size.height);
            x = CGRectGetMaxX(item.cellFrame);
            [items addObject:item];
        }
        self.items = items;
    }
}
- (void)reloadFirstItemContent:(id)content{
    if (self.selectedIndex == 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        HqCategoryItemBaseCell *cell = (HqCategoryItemBaseCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.downArrowIsUp = NO;
        if (content) {
            HqCategoryItem *item = cell.item;
            item.title = content;
            cell.item = item;
        }
    }
}
- (void)initSelectedIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(hhCategoryView:selectedIndex:)] && self.delegate) {
        [self.delegate hhCategoryView:self selectedIndex:index];
    }
    self.selectedIndex = index;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    if (self.showArrow) {
        if (selectedIndex > 0) {
            if ([self.delegate respondsToSelector:@selector(hhCategoryView:isOpenDown:)] && self.delegate) {
                [self.delegate hhCategoryView:self isOpenDown:NO];
            }
        }
    }
    if (selectedIndex<self.items.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [self refreshSelectdIndexPath:indexPath isCallback:NO];
    }

}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    HqCategoryItem *item = self.items[indexPath.row];
    CGFloat itemW = item.cellWidth;
    
    return CGSizeMake(itemW, self.bounds.size.height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.itemSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HqCategoryItemDefaultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HqCategoryItemDefaultCellId forIndexPath:indexPath];
    HqCategoryItem *item = self.items[indexPath.row];
    cell.item = item;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HqCategoryItem *item = self.items[indexPath.row];
    
    if (self.showArrow) {
        if (item.selected && indexPath.row == 0) {
            HqCategoryItemBaseCell *cell = (HqCategoryItemBaseCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.downArrowIsUp = !cell.downArrowIsUp;
            if ([self.delegate respondsToSelector:@selector(hhCategoryView:isOpenDown:)] && self.delegate) {
                [self.delegate hhCategoryView:self isOpenDown:cell.downArrowIsUp];
            }
        }
    }
    if (self.selectedIndex != indexPath.row) {
        if ([self.delegate respondsToSelector:@selector(hhCategoryView:selectedIndex:)] && self.delegate) {
            [self.delegate hhCategoryView:self selectedIndex:indexPath.row];
            [self refreshSelectdIndexPath:indexPath isCallback:YES];
        }
    }

}
- (void)refreshSelectdIndexPath:(NSIndexPath *)indexPath isCallback:(BOOL)isCallback{
    HqCategoryItem *selectedItem = self.items[indexPath.row];
    HqCategoryItem *firstItem = self.items[0];
    if (self.showArrow) {
        if (indexPath.row > 0) {
            firstItem.showArrow = NO;
        }else{
            firstItem.showArrow = YES;
        }
    }

    if (self.selectedIndex != indexPath.row) {
        
        selectedItem.selected = YES;
        
        HqCategoryItem *lastItem = self.items[self.selectedIndex];
        lastItem.selected = NO;
        
        if (self.isZoom) {
            selectedItem.isZoom = YES;
            lastItem.isZoom = NO;
        }

        /*
        NSArray *visibleCells = [self.collectionView visibleCells];
        BOOL isNeedRelaod = YES;
        for (HqCategoryItemBaseCell *cell  in visibleCells) {
            NSIndexPath *visibleIndexPath = [self.collectionView indexPathForCell:cell];
            if (indexPath.row == visibleIndexPath.row) {
                isNeedRelaod = NO;
                break;
            }
        }
        
        if (isNeedRelaod) {
            [self.collectionView reloadData];
        }else{
            HqCategoryItemBaseCell *selectedCell = (HqCategoryItemBaseCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            selectedCell.item = selectedItem;
            
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
            HqCategoryItemBaseCell *lastCell = (HqCategoryItemBaseCell *)[self.collectionView cellForItemAtIndexPath:lastIndexPath];
            lastCell.item = lastItem;
        }
        */
        [self.collectionView reloadData];
        if (isCallback) {
            if ([self.delegate respondsToSelector:@selector(hhCategoryView:selectedIndex:)] && self.delegate) {
                [self.delegate hhCategoryView:self selectedIndex:indexPath.row];
            }
        }
    }
    CGRect cellFrame = selectedItem.cellFrame;
    CGFloat x = CGRectGetMidX(cellFrame) - self.indicatorSize.width/2.0;
    if (indexPath.row > 0) {
        x = x + self.itemSpace*indexPath.row;
    }
    CGRect indicatorViewRect = self.indicatorView.frame;
    indicatorViewRect.origin.x = x;
    self.indicatorView.frame = indicatorViewRect;
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    _selectedIndex = indexPath.row;


}
- (void)scrollViewOffsetX:(CGFloat)OffsetX{
//    NSLog(@"offsetX == %@",@(OffsetX));
    if (OffsetX >=0) {
        CGRect indicatorViewRect = self.indicatorView.frame;
        CGFloat indicatorWidth = indicatorViewRect.size.width;
        CGFloat scale = OffsetX / self.bounds.size.width;
        CGFloat initX = (self.itemWidth - indicatorWidth)/2.0;
        NSLog(@"scale==%@",@(scale));
        indicatorViewRect.origin.x = self.itemSpace + scale * self.itemWidth +initX;
        self.indicatorView.frame = indicatorViewRect;
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    
}

@end


