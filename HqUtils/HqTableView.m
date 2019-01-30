//
//  HqTableView.m
//  HqUtils
//
//  Created by hqmac on 2019/1/30.
//  Copyright © 2019 macpro. All rights reserved.
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
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

@end
