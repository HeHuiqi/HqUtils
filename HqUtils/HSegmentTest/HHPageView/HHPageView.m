//
//  HHPageView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/3/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HHPageView.h"

@interface HHPageView ()<UIScrollViewDelegate>

@end

@implementation HHPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
