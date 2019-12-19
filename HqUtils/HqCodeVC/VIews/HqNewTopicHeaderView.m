//
//  HqNewTopicHeaderView.m
//  HqUtils
//
//  Created by hehuiqi on 2019/11/30.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqNewTopicHeaderView.h"

@implementation HqNewTopicHeaderView
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
        _titleLab.textColor = HqDeepGrayColor;
        _titleLab.text = @"新鲜话题";
    }
    return _titleLab;
}
- (UIButton *)refreshBtn{
    if (!_refreshBtn) {
        _refreshBtn = [[UIButton alloc] init];
        [_refreshBtn setImage:[UIImage imageNamed:@"refresh_red_icon"] forState:UIControlStateNormal];
    }
    return _refreshBtn;
}
- (void)setup{
    [self addSubview:self.titleLab];
    [self addSubview:self.refreshBtn];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(12));
        make.centerY.equalTo(self);
    }];
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(0);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
}
- (void)hqLayoutSuviews{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
