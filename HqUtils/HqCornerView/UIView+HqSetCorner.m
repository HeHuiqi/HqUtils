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
/*
- (void)setCornerRaduis:(CGFloat)raduis{
    UIRectCorner corner = UIRectCornerAllCorners;
    [self setCorner:corner raduis:raduis];
}
- (void)setCorner:(HQUIRectCorner)corner raduis:(CGFloat)raduis{
    
    NSArray *constraints = self.constraints;
    //    NSLog(@"constraints-- %@",constraints);
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if (width == 0 && height == 0) {
        for ( NSLayoutConstraint *c in constraints) {
            if (c.firstAttribute == NSLayoutAttributeWidth) {
                width = c.constant;
            }
            if (c.firstAttribute == NSLayoutAttributeHeight) {
                height = c.constant;
            }
        }
    }
    if (width>0 && height >0) {
        CGRect rect = CGRectMake(0, 0, width, height);
        //绘制圆角 要设置的圆角 使用“|”来组合
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:CGSizeMake(raduis, raduis)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor greenColor].CGColor;;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }else{
        NSString *reason = [NSString stringWithFormat:@"You must set %@'s width and height !!!,than call this method!!!",NSStringFromClass(self.class)];
        NSException *exception = [NSException exceptionWithName:@"SetCorner Fail:" reason:reason userInfo:nil];
        @throw exception;
    }
    
}
*/
@end

