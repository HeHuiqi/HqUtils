//
//  HqBigImagePreview.h
//  HqUtils
//
//  Created by hehuiqi on 11/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface HqBigImagePreview : UIScrollView;

@property(nonatomic,strong) UIImageView *bigImageView;

@property(nonatomic,strong) UIImageView *thumbImageView;//缩略视图
@property(nonatomic,assign) CGRect thumbOriginalViewRect;//缩略视图原始位置;
@property(nonatomic,strong) UIImage *thumbImage;//缩略图片;

- (void)showWiththumbImageView:(UIImageView * _Nullable)thumbImageView;

- (void)showInView:(UIView * _Nullable)inView thumbImageView:(UIImageView * _Nullable)thumbImageView;

@end

NS_ASSUME_NONNULL_END
