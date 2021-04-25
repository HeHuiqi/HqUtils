//
//  HqTabCenterView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/3/16.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqTabCenterView.h"

@implementation HqTabCenterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIImageView *)centerImageView{
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] init];
    }
    return _centerImageView;
}
- (void)setup{
    [self addSubview:self.centerImageView];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageW = 52;
    CGFloat imageX = (self.bounds.size.width - imageW)/2.0;
    CGFloat imageY = (self.bounds.size.height - imageW)/2.0;
    self.centerImageView.frame = CGRectMake(imageX, imageY, imageW, imageW);
}

@end
