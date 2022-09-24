//
//  HqNightModeLayer.m
//  HqUtils
//
//  Created by hehuiqi on 2022/9/24.
//  Copyright © 2022 hhq. All rights reserved.
//

#import "HqNightModeLayer.h"

@interface HqNightModeLayer ()

@property(nonatomic,assign) BOOL isOpen;

@end

@implementation HqNightModeLayer


- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5].CGColor;
    }
    return self;
}

+ (HqNightModeLayer *)shareNightModelLayer{
    static HqNightModeLayer *_nightView;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        _nightView = [[HqNightModeLayer alloc] init];
    });
    return _nightView;
}

+ (void)openNightMode:(BOOL)isOpen{
    
    HqNightModeLayer *nightLayer = [HqNightModeLayer shareNightModelLayer];
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (keyWindow == nil) {
        keyWindow = UIApplication.sharedApplication.delegate.window;
    }
    nightLayer.frame = keyWindow.bounds;
    if (!nightLayer.superlayer) {
        [keyWindow.layer addSublayer:nightLayer];
    }
    nightLayer.isOpen = isOpen;
    SetUserBoolDefault(isOpen,kNightModeIsOpen);
    CGFloat duration = 0.5;
    if (isOpen) {
        nightLayer.opacity = 0.0;
        
        [UIView animateWithDuration:duration animations:^{
            nightLayer.opacity = 1.0;
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            nightLayer.opacity = 0.0;
        } completion:^(BOOL finished) {
            if (nightLayer.superlayer) {
                [nightLayer removeFromSuperlayer];
            }
        }];
    }

    
}
+ (BOOL)isOpenNightMode{
    return  [HqNightModeLayer shareNightModelLayer].isOpen;
}


@end
