//
//  HqUILable.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/19.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqUILable.h"

@implementation HqUILable

- (void)drawTextInRect:(CGRect)rect{
    rect = UIEdgeInsetsInsetRect(rect, self.contentInsets);
    [super drawTextInRect:rect];
}

- (CGSize)intrinsicContentSize{
    CGSize size = [super intrinsicContentSize];
    size.width = size.width + self.contentInsets.left + self.contentInsets.right;
    size.height = size.height + self.contentInsets.top + self.contentInsets.bottom;
    return size;
}

@end
