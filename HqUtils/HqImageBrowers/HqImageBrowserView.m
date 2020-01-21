//
//  HqImageBrowserView.m
//  HqUtils
//
//  Created by hehuiqi on 11/6/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqImageBrowserView.h"
#import "HqImageBrowserCell.h"

@interface HqImageBrowserView ()<UICollectionViewDelegate,UICollectionViewDataSource,HqImageBrowserCellDelegate>

@end

@implementation HqImageBrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGFloat space = 20;
        CGFloat windowW = window.bounds.size.width;
        CGFloat windowH = window.bounds.size.height;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = space;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(windowW, windowH);
        
        //注意这里
        layout.sectionInset = UIEdgeInsetsMake(0, space, 0, space);
        //注意这里
        CGRect rect = CGRectMake(-space, 0, windowW+space, windowH);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];

        [_collectionView registerClass:HqImageBrowserCell.class forCellWithReuseIdentifier:HqImageBrowserCellId];
    }
    return _collectionView;
}


- (void)setup{
    self.backgroundColor = [UIColor blackColor];
    self.currentPage = 0;
    
    [self addSubview:self.collectionView];
}

- (void)setImageDatas:(NSArray *)imageDatas{
    _imageDatas = imageDatas;
    if (_imageDatas) {
        [self.collectionView reloadData];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:0] atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
    }
}

- (void)showInView:(UIView * _Nullable)inView thumbImageView:(UIImageView * _Nullable)thumbImageView{
    if (!inView) {
         inView = [UIApplication sharedApplication].keyWindow;
     }
    self.frame = inView.bounds;
    [inView addSubview:self];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageDatas.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HqImageBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HqImageBrowserCellId forIndexPath:indexPath];
//    NSLog(@"self.thumbImageView==%@",self.thumbImageView);
    if (indexPath.row == self.currentPage) {
        cell.thumbImageView = self.thumbImageView;
    }
    cell.imageUrl = self.imageDatas[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = (NSInteger)scrollView.contentOffset.x/scrollView.bounds.size.width;
    self.currentPage = index;
    NSLog(@"self.currentPage==%@",@(self.currentPage));
}
#pragma mark - HqImageBrowserCellDelegate
- (void)tapDismissView:(HqImageBrowserCell *)cell{
    
    if (cell.thumbImageView) {
        [UIView animateWithDuration:0.3 animations:^{
            cell.bigImageView.frame = cell.thumbOriginalViewRect;
            self.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            cell.bigImageView.alpha = 0;
            self.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
