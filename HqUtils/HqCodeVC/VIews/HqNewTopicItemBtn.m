//
//  HqNewTopicControl.m
//  LC
//
//  Created by hehuiqi on 2019/11/30.
//  Copyright © 2019 youfu. All rights reserved.
//

#import "HqNewTopicItemBtn.h"

@implementation HqNewTopicItemBtn
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UILabel *)topicNameLab{
    if (!_topicNameLab) {
        _topicNameLab = [[UILabel alloc] init];
        _topicNameLab.font = SetFont(kZoomValue(13));
    }
    return _topicNameLab;
}
- (UIImageView *)topicFlagIcon{
    if (!_topicFlagIcon) {
        _topicFlagIcon = [[UIImageView alloc] init];
        _topicFlagIcon.hidden = YES;
    }
    return _topicFlagIcon;
}
- (void)setup{
    self.clipsToBounds = YES;
    UIImage *image = [self getBgImageWithSize:CGSizeMake(10, 10) cornerRaius:0];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    
    [self addSubview:self.topicNameLab];
    [self addSubview:self.topicFlagIcon];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    [self.topicNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(12));
        make.centerY.equalTo(self);
        make.right.mas_lessThanOrEqualTo(self).offset(kZoomValue(-12));
    }];
    [self.topicFlagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topicNameLab.mas_right).offset(kZoomValue(10));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(14);
    }];
    self.topicNameLab.backgroundColor = HqRandomColor;
    self.topicFlagIcon.backgroundColor = HqRandomColor;
}
- (void)setTopic:(id)topic{
    _topic = topic;
    self.topicNameLab.text = topic;
}
- (void)setFlagWith:(CGFloat)flagWith{
    _flagWith = flagWith;
    CGFloat haveFlagRighSpace = kZoomValue(22)+flagWith;
    BOOL haveFlag = flagWith>0;
    CGFloat nameLabRithSpace = haveFlag ? -haveFlagRighSpace:kZoomValue(-12);
    self.topicFlagIcon.hidden = !haveFlag;
    if (haveFlag) {
        [self.topicFlagIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(flagWith);
        }];
    }
    [self.topicNameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_lessThanOrEqualTo(self).offset(nameLabRithSpace);
    }];
}
- (UIImage *)getBgImageWithSize:(CGSize)cgsize cornerRaius:(CGFloat)cornerRaius{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.bounds =CGRectMake(0, 0, cgsize.width, cgsize.height);
    if (cornerRaius>0) {
        view.layer.cornerRadius = cornerRaius;
        view.clipsToBounds = YES;
    }
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"image==%@",image);
    return image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
