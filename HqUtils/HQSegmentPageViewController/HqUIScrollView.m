//
//  HqUIScrollView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/5/8.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqUIScrollView.h"
@implementation HqUIScrollView

// 是否允许同时支持多个手势，默认是不支持多个手势
// 返回yes表示支持多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer.view == self) {
        if (self.contentOffset.x <= 0 && gestureRecognizer.state != UIGestureRecognizerStatePossible) {
            return YES;
        }
    }
    return NO;
}
// 每次触摸屏幕时保证collectionView第一时间可以响应滚动
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    self.scrollEnabled = YES;
    return [super hitTest:point withEvent:event];
}



@end
