//
//  HHSegmentCell.m
//  HqUtils
//
//  Created by hehuiqi on 5/28/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HHSegmentCell.h"

@implementation HHSegmentCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    _titleLab = [[UILabel alloc] init];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLab];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _titleLab.frame = CGRectMake(0, 0,width, height);
}

@end
