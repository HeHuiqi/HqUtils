//
//  HqLoopImageCell.m
//  GlobalPay
//
//  Created by hqmac on 2018/8/27.
//  Copyright © 2018年 solar. All rights reserved.
//

#import "HqLoopImageCell.h"

@implementation HqLoopImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (UIImageView *)bannerImageView{
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bannerImageView.clipsToBounds = YES;
        
    }
    return _bannerImageView;
}
- (UILabel *)hqTitleLab{
    if (!_hqTitleLab) {
        _hqTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        _hqTitleLab.backgroundColor = [UIColor redColor];
        _hqTitleLab.textAlignment = NSTextAlignmentCenter;
        _hqTitleLab.font = [UIFont systemFontOfSize:18];
    }
    return _hqTitleLab;
}
- (void)setup{

    [self addSubview:self.bannerImageView];


    [self addSubview:self.hqTitleLab];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.bannerImageView.frame = self.bounds;
}
- (void)setBanner:(HqBanner *)banner{
    _banner = banner;
    if (_banner) {
        self.hqTitleLab.text = banner.name;
        if (banner.icon.length>0) {
            self.bannerImageView.image = [UIImage imageNamed:banner.icon];
        }else{
            if (banner.imageUrl.length>0) {
                NSURL *url = [NSURL URLWithString:banner.imageUrl];
                [self.bannerImageView sd_setImageWithURL:url placeholderImage:nil];
            }
        }
    }
}

@end
