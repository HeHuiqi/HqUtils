//
//  HqMoreActionItemView.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/12.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqMoreActionItemView.h"

@implementation HqMoreActionItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _actionBtn;
}
- (UILabel *)actionInfoLab{
    if (!_actionInfoLab) {
        _actionInfoLab = [[UILabel alloc] init];
        _actionInfoLab.font = SetFont(11);
        _actionInfoLab.textColor = HqLightGrayColor;
    }
    return _actionInfoLab;
}
- (void)setup{
    [self addSubview:self.actionBtn];
    [self addSubview:self.actionInfoLab];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(58, 58));
    }];
    [self.actionInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.actionBtn.mas_bottom).offset(6);
    }];
    
}
- (void)setItem:(HqListItemModel *)item{
    _item = item;
    if(_item){
        UIImage *image = [UIImage imageNamed:item.hq_icon_name];
        [self.actionBtn setImage:image forState:UIControlStateNormal];
        self.actionInfoLab.text = item.hq_key;
    }
}

@end
