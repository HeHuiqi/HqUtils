//
//  HqPullZoomView.m
//  OC-Use
//
//  Created by macpro on 2017/6/19.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "HqPullZoomView.h"

#define HqKeyPathContentOffset @"contentOffset"

@interface HqPullZoomView ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation HqPullZoomView

- (void)dealloc{
    [self removeObservers];
}

- (void)showInView:(UIScrollView *)scrollView{
    [self removeFromSuperview];
    _scrollView = scrollView;
    if (_scrollView) {
    
        [_scrollView insertSubview:self atIndex:0];

        _scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
        NSLog(@"startOffetY = %f",_scrollView.contentOffset.y);

        [self addObservers];

        CGPoint offset = _scrollView.contentOffset;
        
        if ([scrollView isKindOfClass:[UIScrollView class]]) {
            if (offset.y==0) {
                offset = CGPointMake(0, -scrollView.contentInset.top);
                _scrollView.contentOffset = offset;
            }
        }

    }
}

#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:HqKeyPathContentOffset options:options context:nil];

}

- (void)removeObservers
{
    [self.scrollView removeObserver:self forKeyPath:HqKeyPathContentOffset];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:HqKeyPathContentOffset]) {
        NSValue *offset = (NSValue *)(change[NSKeyValueChangeNewKey]);
        CGFloat offsetY = offset.CGPointValue.y;
        
        NSLog(@"offsetY = %f",offsetY);
        if (offsetY<0) {
            
            CGRect rect = self.frame;
            if (-offsetY<=0) {
                return;
            }
            rect.origin.y = offsetY;
            rect.size.height = -offsetY;
            self.frame = rect;
        }
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
