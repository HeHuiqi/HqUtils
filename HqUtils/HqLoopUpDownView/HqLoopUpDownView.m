//
//  HqLoopUpDownView.m
//  HqUtils
//
//  Created by hehuiqi on 2020/1/8.
//  Copyright © 2020 hhq. All rights reserved.
//

#import "HqLoopUpDownView.h"
#define HqLoopUpDownViewInterval 4

@implementation HqLoopUpDownView

- (void)dealloc{
    [self.loopTimer invalidate];
    self.loopTimer = nil;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.loopIndex = -1;
        [self setup];
    }
    return self;
}
- (NSTimer *)loopTimer{
    if (!_loopTimer) {
        _loopTimer = [NSTimer scheduledTimerWithTimeInterval:HqLoopUpDownViewInterval target:self selector:@selector(startLoop) userInfo:nil repeats:YES];
    }
    return _loopTimer;
}
- (HqLoopUpDownItemView *)showItemView{
    if (!_showItemView) {
        _showItemView = [[HqLoopUpDownItemView alloc] init];
    }
    return _showItemView;
}
- (HqLoopUpDownItemView *)hideItemView{
    if (!_hideItemView) {
        _hideItemView = [[HqLoopUpDownItemView alloc] init];
    }
    return _hideItemView;
}
- (void)setup{
    [self addSubview:self.showItemView];
    [self addSubview:self.hideItemView];
    [self hqLayoutSuviews];
    self.showItemView.backgroundColor = [UIColor yellowColor];
    self.hideItemView.backgroundColor = [UIColor blueColor];
    self.clipsToBounds = YES;
    [self.showItemView addTarget:self action:@selector(clickItemView:) forControlEvents:UIControlEventTouchUpInside];
    [self.hideItemView addTarget:self action:@selector(clickItemView:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickItemView:(HqLoopUpDownItemView *)view{
    if ([self.delegate respondsToSelector:@selector(hqLoopUpDownView:clickItem:)] && self.delegate) {
        [self.delegate hqLoopUpDownView:self clickItem:view.item];
    }
    [self.loopTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:HqLoopUpDownViewInterval]];
}
- (void)hqLayoutSuviews{
    
}
- (void)setItems:(NSArray *)items{
    _items = items;
    if (_items) {
        self.showItemView.item  = items[0];
        if (items.count>1) {
            self.hideItemView.item = items[1];
            [self loopTimer];
        }
    }
}
- (void)loopIndex:(NSInteger)index{
    CGFloat height = self.bounds.size.height;
//    CGFloat width = self.bounds.size.width;
    
    self.showItemView.item = self.items[index];
    NSInteger nextIndex = index+1;
    nextIndex = nextIndex==self.items.count ? 0:nextIndex;
    self.hideItemView.item = self.items[nextIndex];
    
    CGRect showRect = self.showItemView.frame;
    showRect.origin.y = -height;
    CGRect hideRect = self.hideItemView.frame;
    hideRect.origin.y = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.showItemView.frame = showRect;
        self.hideItemView.frame = hideRect;
    } completion:^(BOOL finished) {
        CGRect resetShowRect = self.showItemView.frame;
        resetShowRect.origin.y  = height;
        self.showItemView.frame = resetShowRect;
        HqLoopUpDownItemView *tempItemView = self.showItemView;
        self.showItemView = self.hideItemView;
        self.hideItemView = tempItemView;
        
    }];
}
- (void)layoutSubviews{
    [super layoutSubviews];
 
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    CGFloat leftSpace = 0;
    self.showItemView.frame = CGRectMake(leftSpace, 0, width-leftSpace, height);
    self.hideItemView.frame = CGRectMake(leftSpace, height, width-leftSpace, height);

}
- (void)startLoop{
    self.loopIndex++;
    if (self.loopIndex>=self.items.count) {
        self.loopIndex = 0;
    }
    [self loopIndex:self.loopIndex];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
