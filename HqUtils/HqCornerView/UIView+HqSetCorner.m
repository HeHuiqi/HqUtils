//
//  UIView+HqSetCorner.m
//  HqUtils
//
//  Created by hqmac on 2019/3/8.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "UIView+HqSetCorner.h"
#import <objc/message.h>

@implementation UIView (HqSetCorner)


- (void)setHqRaduis:(CGFloat)hqRaduis{
    objc_setAssociatedObject(self, @selector(hqRaduis), @(hqRaduis), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)hqRaduis{
    id raduis =  objc_getAssociatedObject(self, _cmd);
    return [raduis floatValue];
}

- (void)setHqCorner:(HQUIRectCorner)hqCorner{
    objc_setAssociatedObject(self, @selector(hqCorner), @(hqCorner), OBJC_ASSOCIATION_ASSIGN);
}
- (HQUIRectCorner)hqCorner{
    id courner = objc_getAssociatedObject(self, _cmd);
    return [courner integerValue];
}


- (void)hqSetCornerRaduis:(CGFloat)raduis{
    self.hqCorner = HQUIRectCornerAllCorners;
    self.hqRaduis = raduis;
}
- (void)hqSetCorner:(HQUIRectCorner)corner raduis:(CGFloat)raduis{
    self.hqCorner = corner;
    self.hqRaduis = raduis;
}


- (void)layoutSubviews{
    if (self.hqRaduis > 0 ) {
        CGRect rect = self.bounds;
        //绘制圆角 要设置的圆角 使用“|”来组合
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:self.hqCorner cornerRadii:CGSizeMake(self.hqRaduis, self.hqRaduis)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor greenColor].CGColor;;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        maskPath.lineWidth = 2;
    }
    
    
}

- (void)hqSetCornerRaduis:(CGFloat)raduis borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    UIColor *bgColor = self.backgroundColor==nil ? [UIColor whiteColor]:self.backgroundColor;
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.frame = self.bounds;
    [self.layer addSublayer:bgLayer];
//    bgLayer.fillRule = kCAFillRuleNonZero;
    bgLayer.fillColor = bgColor.CGColor;
//    bgLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithRect:bgLayer.bounds];
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:bgLayer.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(raduis, raduis)];
    [bgPath appendPath:clipPath];
//    [clipPath appendPath:bgPath];
    clipPath.usesEvenOddFillRule = YES;
    [clipPath addClip];
    
    bgLayer.path = clipPath.CGPath;
//    self.layer.mask = bgLayer;
    
//    if (borderWidth>0) {
//        CAShapeLayer *borderlayer = [CAShapeLayer layer];
//        UIBezierPath *borderPath = clipPath;
//        borderlayer.fillColor = [UIColor clearColor].CGColor;
//        borderlayer.strokeColor = borderColor.CGColor;
//        borderlayer.path = borderPath.CGPath;
//        [self.layer addSublayer:borderlayer];
//    }
}
@end

