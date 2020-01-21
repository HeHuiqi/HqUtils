//
//  HqProgressBarView.h
//  LC
//
//  Created by hehuiqi on 2019/12/24.
//  Copyright © 2019 youfu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqProgressBarView : UIView


@property(nonatomic,strong) UIView *trackView;
@property(nonatomic,strong) UIView *progressView;
@property(nonatomic,strong) UIColor *progressColor;
@property(nonatomic,strong) UIColor *trackColor;
@property(nonatomic,assign) CGFloat animationDuration;//默认0.3
@property(nonatomic,assign) CGFloat progress;//进度 0-1.0;
//动画更新
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
