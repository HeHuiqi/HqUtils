//
//  HqLoopUpDownItemView.m
//  HqUtils
//
//  Created by hehuiqi on 2020/1/8.
//  Copyright © 2020 hhq. All rights reserved.
//

#import "HqLoopUpDownItemView.h"

@implementation HqLoopUpDownItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = SetFont(kZoomValue(14));
    }
    return _titleLab;
}
- (void)setup{
    [self addSubview:self.titleLab];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    
}
- (void)layoutSubviews{
    self.titleLab.frame = self.bounds;
}
-(void)setItem:(HqLoopUpDownItem *)item{
    _item = item;
    self.titleLab.text =  item.title;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
