//
//  HqLable.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/19.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqLable.h"

@implementation HqLable

- (void)drawTextInRect:(CGRect)rect{
    rect = UIEdgeInsetsInsetRect(rect, self.contentInsets);
    [super drawTextInRect:rect];
}

- (CGSize)intrinsicContentSize{
    CGSize size = [super intrinsicContentSize];
    if (!UIEdgeInsetsEqualToEdgeInsets(self.contentInsets, UIEdgeInsetsZero) && self.text.length > 0) {
        size.width = size.width + self.contentInsets.left + self.contentInsets.right;
        size.height = size.height + self.contentInsets.top + self.contentInsets.bottom;

    }
    return size;
}

@end
