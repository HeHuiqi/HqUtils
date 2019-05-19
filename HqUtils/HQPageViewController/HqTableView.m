//
//  HqTableView.m
//  HqUtils
//
//  Created by hehuiqi on 4/23/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTableView.h"

@implementation HqTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
