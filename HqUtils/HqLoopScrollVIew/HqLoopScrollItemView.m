//
//  HqLoopScrollItemView.m
//  HqUtils
//
//  Created by hehuiqi on 2020/1/21.
//  Copyright © 2020 hhq. All rights reserved.
//

#import "HqLoopScrollItemView.h"

@implementation HqLoopScrollItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:30];
        _titleLab.textColor = HqRandomColor;
    }
    return _titleLab;
}
- (void)setup{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLab];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.titleLab.frame = self.bounds;
}

- (void)setScollItem:(HqLoopScrollItem *)scollItem{
    _scollItem = scollItem;
    if (_scollItem) {
        self.titleLab.text = scollItem.title;
        if (scollItem.imageName.length>0) {
            self.imageView.image = [UIImage imageNamed:scollItem.imageName];
        }else{
            if (scollItem.imageUrl.length>0) {
                NSURL *url = [NSURL URLWithString:scollItem.imageUrl];
                [self.imageView sd_setImageWithURL:url placeholderImage:nil];
            }
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
