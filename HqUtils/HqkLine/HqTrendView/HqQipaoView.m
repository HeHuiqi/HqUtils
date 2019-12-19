//
//  HqQipaoView.m
//  GlobalPay
//
//  Created by hqmac on 2018/8/30.
//  Copyright © 2018年 solar. All rights reserved.
//

#import "HqQipaoView.h"
@interface HqQipaoView()
@property (nonatomic,strong) UIImageView *bgImageView;
@end

@implementation HqQipaoView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
    UIImage *bg = [UIImage imageNamed:@"qipao_icon"];
    bg = [ bg resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 10, 5)];
    
    _bgImageView = [[UIImageView alloc] init];
    [self addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.centerX.equalTo(self);
    }];
    self.bgImageView.image = bg;


    
    //qipao_icon
    _topLab = [[UILabel alloc] init];
    _topLab.textColor = HqOrangeColor;
    _topLab.font = SetFont(kZoomValue(10));
    [self addSubview:_topLab];
    [_topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(10));
        make.top.equalTo(self).offset(kZoomValue(5));
    }];
    
    _bottomLab = [[UILabel alloc] init];
    _bottomLab.textColor = HqGrayColor;
    _bottomLab.font = SetFont(kZoomValue(10));
    [self addSubview:_bottomLab];
    [_bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(10));
        make.top.equalTo(self.topLab.mas_bottom).offset(kZoomValue(2));
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
