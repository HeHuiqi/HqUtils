//
//  HqYCoordinateView.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/9.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqYCoordinateView.h"

@implementation HqYCoordinateView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UILabel *)lab1{
    if (!_lab1) {
        _lab1 = [[UILabel alloc] init];
        _lab1.font = SetFont(kZoomValue(12));
        _lab1.lineBreakMode = NSLineBreakByClipping;
        _lab1.clipsToBounds = YES;
    }
    return _lab1;
}
- (UILabel *)lab2{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        _lab2.font = SetFont(kZoomValue(12));
        _lab2.lineBreakMode = NSLineBreakByClipping;
        _lab2.clipsToBounds = YES;


    }
    return _lab2;
}
- (UILabel *)lab3{
    if (!_lab3) {
        _lab3 = [[UILabel alloc] init];
        _lab3.font = SetFont(kZoomValue(12));
        _lab3.lineBreakMode = NSLineBreakByClipping;
        _lab3.clipsToBounds = YES;

    }
    return _lab3;
}
- (UILabel *)lab4{
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.font = SetFont(kZoomValue(12));
        _lab4.lineBreakMode = NSLineBreakByClipping;
        _lab4.clipsToBounds = YES;
    }
    return _lab4;
}
- (void)setup{
    [self addSubview:self.lab1];
    [self addSubview:self.lab2];
    [self addSubview:self.lab3];
    [self addSubview:self.lab4];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSArray *labs = @[self.lab1,self.lab2,self.lab3,self.lab4];
    CGFloat labW = self.bounds.size.width;
    CGFloat labH = self.lab1.font.pointSize;
    CGFloat labSpace = self.bounds.size.height/3;
    for (int i = 0; i<labs.count; i++) {
        UILabel *lab = labs[i];
        lab.frame = CGRectMake(0, (i)*labSpace-labH/2.0,labW, labH);
    }
}
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    if (_datas) {
        NSArray *labs = @[self.lab1,self.lab2,self.lab3,self.lab4];
        for (int i = 0; i<datas.count; i++) {
            UILabel *lab = labs[i];
            lab.text = datas[i];
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
