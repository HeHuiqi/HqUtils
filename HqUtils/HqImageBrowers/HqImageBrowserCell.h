//
//  HqImageBrowserCell.h
//  HqUtils
//
//  Created by hehuiqi on 11/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HqImageBrowserCellId @"HqImageBrowserCell"

NS_ASSUME_NONNULL_BEGIN

@protocol HqImageBrowserCellDelegate;
@interface HqImageBrowserCell : UICollectionViewCell

@property(nonatomic,weak) id<HqImageBrowserCellDelegate> delegate;

@property(nonatomic,strong) UIScrollView *contentScrollView;
@property(nonatomic,strong) UIImageView *bigImageView;

@property(nonatomic,strong) UIImageView *thumbImageView;//缩略视图
@property(nonatomic,assign) CGRect thumbOriginalViewRect;//缩略视图原始位置;
@property(nonatomic,strong) UIImage *thumbImage;//缩略图片;


@end

@protocol HqImageBrowserCellDelegate <NSObject>

@optional
- (void)tapDismissView:(HqImageBrowserCell *)cell;

@end

NS_ASSUME_NONNULL_END
