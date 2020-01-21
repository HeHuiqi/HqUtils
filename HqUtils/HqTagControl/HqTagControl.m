//
//  HqTagControl.m
//  HqUtils
//
//  Created by hehuiqi on 2020/1/14.
//  Copyright © 2020 hhq. All rights reserved.
//

#import "HqTagControl.h"

@implementation HqTagControl

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftRightSpace  = 5;
        self.iconLabSpace = 5;
        [self setup];
    }
    return self;
}
- (UIImageView *)leftIcon{
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc] init];
        _leftIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftIcon;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = SetFont(12);
    }
    return _titleLab;
}
- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc] init];
        _rightIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightIcon;
}
- (void)setup{
    [self addSubview:self.leftIcon];
    [self addSubview:self.titleLab];
    [self addSubview:self.rightIcon];
}
- (void)setStyle:(HqTagControlStyle)style{
    _style = style;
    switch (style) {
        case HqTagControlStyleDefault:
        {
            [self defaultLayout];
        }
            break;
        case HqTagControlStyleHaveLeftIcon:
        {
            [self haveLeftIconLayout];
        }
            break;
        case HqTagControlStyleHaveRightIcon:
        {
            [self haveRightIconLayout];
        }
            break;
        case HqTagControlStyleHaveLeftRightIcon:
        {
            [self haveLeftRightIconLayout];
        }
            break;
        default:
            break;
    }
    self.titleLab.backgroundColor = HqRandomColor;
}
- (void)defaultLayout{
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.leftRightSpace);
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-self.leftRightSpace);
    }];
}
- (void)haveLeftIconLayout{

}
- (void)haveRightIconLayout{
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-self.leftRightSpace);
        make.centerY.equalTo(self);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.leftRightSpace);
        make.centerY.equalTo(self);
        make.right.equalTo(self.rightIcon.mas_right).offset(-self.iconLabSpace);
    }];
}
- (void)haveLeftRightIconLayout{
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.leftRightSpace);
        make.centerY.equalTo(self);
    }];
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-self.leftRightSpace);
        make.centerY.equalTo(self);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIcon.mas_right).offset(self.iconLabSpace);
        make.centerY.equalTo(self);
        make.right.equalTo(self.rightIcon.mas_left).offset(-self.iconLabSpace);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
