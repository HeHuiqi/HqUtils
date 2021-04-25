//
//  HqCategoryItemDefaultCell.m
//  HqUtils
//
//  Created by hehuiqi on 2021/3/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqCategoryItemDefaultCell.h"

@implementation HqCategoryItemDefaultCell


- (void)setup{
    [super setup];
    [self addSubview:self.downArrowIcon];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.downArrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.titleLab.mas_right).offset(5);
    }];
    [super hqLayoutSuviews];
}

@end
