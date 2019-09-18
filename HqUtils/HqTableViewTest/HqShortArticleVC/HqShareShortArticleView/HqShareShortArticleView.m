//
//  HqShareShortArticleView.m
//  HqUtils
//
//  Created by hehuiqi on 7/2/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqShareShortArticleView.h"

@implementation HqShareShortArticleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    _headerView = [[UIView alloc] init];
    [self addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-30);

        make.height.mas_equalTo(kZoomValue(100));
    }];
    
    _contentLab = [[UILabel alloc] init];
    _contentLab.numberOfLines = 0;
    [self addSubview:_contentLab];
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kZoomValue(100));
        make.left.equalTo(self).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-60);
    }];
    _footerView = [[UIView alloc] init];
    [self addSubview:_footerView];
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_equalTo(kZoomValue(100));
    }];
    _headerView.backgroundColor = [UIColor blueColor];
    _footerView.backgroundColor = [UIColor greenColor];
    self.backgroundColor = [UIColor redColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
