//
//  HqLab.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/23.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqLab.h"

@implementation HqLab


- (void)setFrame:(CGRect)frame{
    
    self.text = self.text;
    CGSize size = [self sizeThatFits:CGSizeMake(CGRectGetWidth(frame), CGFLOAT_MAX)];
    if (frame.size.width > 0 &&isinf(frame.size.height)) {
        frame.size.height = size.height;
    }
    [super setFrame:frame];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
