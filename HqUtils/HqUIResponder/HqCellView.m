//
//  HqCellView.m
//  HqUtils
//
//  Created by hqmac on 2019/3/14.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqCellView.h"

@implementation HqCellView

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"HqCellView-touchesEnded");
    [self.nextResponder touchesEnded:touches withEvent:event];
}
- (void)tintColorDidChange{
    NSLog(@"HqCellView-tintColorDidChange");
    self.backgroundColor = self.tintColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
