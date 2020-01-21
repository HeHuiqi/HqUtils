//
//  HqProgressBarView.m
//  LC
//
//  Created by hehuiqi on 2019/12/24.
//  Copyright © 2019 youfu. All rights reserved.
//

#import "HqProgressBarView.h"
@interface HqProgressBarView()

@property(nonatomic,assign) BOOL progressAnimated;

@end
@implementation HqProgressBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIView *)trackView{
    if (!_trackView) {
        _trackView = [[UIView alloc] init];
        _trackView.backgroundColor = [UIColor lightGrayColor];
    }
    return _trackView;
}
- (UIView *)progressView{
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor systemBlueColor];
    }
    return _progressView;
}
- (void)setTrackColor:(UIColor *)trackColor{
    _trackColor = trackColor;
    self.trackView.backgroundColor = trackColor;
}
- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.progressView.backgroundColor = progressColor;
}
- (void)setup{
    self.animationDuration = 0.3;
    [self addSubview:self.trackView];
    [self addSubview:self.progressView];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsLayout];
}
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    _progress = progress;
    _progressAnimated = animated;
    [self setNeedsLayout];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.trackView.frame = self.bounds;
    CGFloat progressViewW = self.bounds.size.width*self.progress;
    if (self.progressAnimated) {
        NSLog(@"animated");
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.progressView.frame = CGRectMake(0, 0, progressViewW, self.bounds.size.height);
        } completion:^(BOOL finished) {
            self.progressAnimated = NO;
        }];
    }else{
        NSLog(@"no animated");
        self.progressView.frame = CGRectMake(0, 0, progressViewW, self.bounds.size.height);
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
