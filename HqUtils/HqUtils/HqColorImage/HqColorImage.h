//
//  HqColorImage.h
//  customerKeyboard
//
//  Created by macpro on 2018/1/24.
//  Copyright © 2018年 HHQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqColorImage : UIView

@property (nonatomic,strong) UIColor *fillColor;
@property (nonatomic,assign) BOOL isBorder;

@property (nonatomic,readonly) UIImage *corloImage;

- (instancetype)initWithFillColor:(UIColor *)fillColor isBorder:(BOOL)isBorder;

+ (UIImage *)imageWithColor:(UIColor *)color isBorder:(BOOL)isBorder;
+ (UIImage *)imageWithColor:(UIColor *)color;


@end
