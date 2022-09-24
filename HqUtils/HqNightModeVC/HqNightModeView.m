//
//  HqNightModeView.m
//  HqUtils
//
//  Created by hehuiqi on 2022/9/24.
//  Copyright © 2022 hhq. All rights reserved.
//

#import "HqNightModeView.h"


@interface HqNightModeView ()
@property(nonatomic,assign) BOOL isOpen;

@end

@implementation HqNightModeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        //关键点，使其不能响应用户事件
        self.userInteractionEnabled = NO;
    }
    return  self;
}

+ (HqNightModeView *)shareNightModelView{
    static HqNightModeView *_nightView;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        _nightView = [[HqNightModeView alloc] init];
    });
    return _nightView;
}

+ (void)openNightMode:(BOOL)isOpen{
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    HqNightModeView *nightView = [HqNightModeView shareNightModelView];
    nightView.frame = keyWindow.bounds;
    if (!nightView.superview) {
        [keyWindow addSubview:nightView];
    }
    if (isOpen) {
        nightView.alpha = 0.0;
        
        [UIView animateWithDuration:0.3 animations:^{
            nightView.alpha = 1.0;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            nightView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (nightView.superview) {
                [nightView removeFromSuperview];
            }
        }];
    }

    
}
+ (BOOL)isOpenNightMode{
    return  [HqNightModeView shareNightModelView].isOpen;
}

@end
