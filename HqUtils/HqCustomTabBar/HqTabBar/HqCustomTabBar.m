//
//  HqTabBar.m
//  HqUtils
//
//  Created by hehuiqi on 2021/3/16.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqCustomTabBar.h"
#import "UIView+Extension.h"

@implementation HqCustomTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage * shadowImage = [UIImage new];
        self.shadowImage = shadowImage;
        self.backgroundImage = shadowImage;
        
        UIColor *color = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = color.CGColor;
        self.layer.shadowOpacity = 0.3;
        
        [self setup];
    }
    return self;
}
- (HqTabCenterView *)centerView{
    if (!_centerView) {
        _centerView = [[HqTabCenterView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        UIImage *centerBtnImage = [UIImage imageNamed:@"lc_tab_mining_selected_icon"];
        _centerView.centerImageView.image = centerBtnImage;
    }
    return _centerView;
}

- (void)setup{
    [self addSubview:self.centerView];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.centerView.centerX = self.centerX;
    self.centerView.centerY = 5;
    CGFloat btnW = 62;
    self.centerView.size = CGSizeMake(btnW, btnW);
    self.centerView.layer.cornerRadius = btnW/2.0;
}

@end
