//
//  HqColorImage.m
//  customerKeyboard
//
//  Created by macpro on 2018/1/24.
//  Copyright © 2018年 HHQ. All rights reserved.
//

#import "HqColorImage.h"

@interface HqColorImage()

@property (nonatomic,strong) CAShapeLayer *bglayer;

@end

@implementation HqColorImage

- (instancetype)init{
    if (self = [super init]) {
        _isBorder = NO;
    }
    return self;
}
- (instancetype)initWithFillColor:(UIColor *)fillColor isBorder:(BOOL)isBorder{
    if (self = [super init]) {
        self.bounds = CGRectMake(0, 0, 15, 15);
        self.isBorder =  isBorder;
        self.fillColor = fillColor;
    }
    return self;
}
- (CAShapeLayer *)bglayer{
    if (!_bglayer) {
        _bglayer = [CAShapeLayer layer];
        _bglayer.lineWidth = 2.0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:4.0];
        _bglayer.cornerRadius = 4.0;
        _bglayer.path = path.CGPath;        
    }
    return _bglayer;
}

- (void)setIsBorder:(BOOL)isBorder{
    _isBorder = isBorder;
    [self setFillColor:_fillColor];
}
- (void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    if (_fillColor) {
        [self.bglayer removeFromSuperlayer];
        if (_isBorder) {
            self.bglayer.fillColor = [UIColor clearColor].CGColor;
            self.bglayer.strokeColor = _fillColor.CGColor;
        }else{
            self.bglayer.strokeColor = [UIColor clearColor].CGColor;
            self.bglayer.fillColor = _fillColor.CGColor;
        }
        [self.layer addSublayer:self.bglayer];
    }
}
- (UIImage *)corloImage{
    return [self convertViewToImage:self];
}

- (UIImage*)convertViewToImage:(UIView*)view{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)];
    return image;
}
+ (UIImage *)imageWithColor:(UIColor *)color isBorder:(BOOL)isBorder {
    HqColorImage *colorImage = [[HqColorImage alloc] initWithFillColor:color isBorder:isBorder ];
    UIImage *image = [colorImage.corloImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    return [self imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
