//
//  HqTopicBannerCell.m
//  HqUtils
//
//  Created by hehuiqi on 2019/11/30.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTopicBannerCell.h"

@implementation HqTopicBannerCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIView *)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _topLine;
}
- (UIView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[UIView alloc] init];
        _bannerView.backgroundColor = [UIColor whiteColor];
    }
    return _bannerView;
}
- (void)setup{
    [self addSubview:self.topLine];
    [self addSubview:self.bannerView];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, kZoomValue(8)));
    }];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLine.mas_bottom).offset(0);
        make.left.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, kZoomValue(143)));
        make.bottom.equalTo(self).offset(0);
    }];
}
- (void)hqLayoutSubviews{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
