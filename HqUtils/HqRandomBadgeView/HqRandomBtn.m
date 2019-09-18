//
//  HqRandomBtn.m
//  HqUtils
//
//  Created by hehuiqi on 8/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqRandomBtn.h"

@implementation HqRandomBtn

- (void)setRandomModel:(HqRandomModel *)randomModel{
    _randomModel = randomModel;
    if (_randomModel) {
        [self setTitle:randomModel.dataValue forState:UIControlStateNormal];
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
