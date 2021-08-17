//
//  HqArrowImage.m
//  HqUtils
//
//  Created by hehuiqi on 2021/5/28.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqArrowImage.h"

@interface HqArrowImage ()
@property(nonatomic,assign,readonly) CGSize backIconSize;
@property(nonatomic,assign,readonly) CGSize tableArrowIconSize;

@end

@implementation HqArrowImage


- (CGSize)backIconSize{
    return CGSizeMake(12.0, 20.0);
}
- (CGSize)tableArrowIconSize{
    return CGSizeMake(8.0, 14.0);
}

- (instancetype)init{
    if (self = [super init]) {
        _imageSize = self.tableArrowIconSize;
        _arrowPosition = HqArrowImagePositionRight;
        _arrowStyle = HqArrowImageStyleStroke;
        _arrowColor = [UIColor systemBlueColor];
        _lineWidth = 2.0;
    }
    return self;
}
- (UIImage *)makeImage{
    UIImage *arromImage = nil;
    CGFloat lineHalfWidth = self.lineWidth/2.0;
    CGFloat arrowWidth = self.imageSize.width + lineHalfWidth;
    CGFloat arrowHeight = self.imageSize.height + lineHalfWidth;
    CGSize tagretSize = CGSizeMake(arrowWidth, arrowHeight);
    UIGraphicsBeginImageContextWithOptions(tagretSize, NO, 0.0f);
    {
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPath];
        rectanglePath.lineCapStyle  = kCGLineCapRound;
        rectanglePath.lineJoinStyle = kCGLineJoinMiter;

        switch (self.arrowPosition) {
            case HqArrowImagePositionTop:
                [rectanglePath moveToPoint: CGPointMake(lineHalfWidth, arrowHeight-lineHalfWidth)];
                [rectanglePath addLineToPoint: CGPointMake(arrowWidth/2.0, lineHalfWidth)];
                [rectanglePath addLineToPoint: CGPointMake(arrowWidth-lineHalfWidth, arrowHeight-lineHalfWidth)];

                break;
                
            case HqArrowImagePositionLeft:
                [rectanglePath moveToPoint: CGPointMake(arrowWidth-lineHalfWidth, lineHalfWidth)];
                [rectanglePath addLineToPoint: CGPointMake(lineHalfWidth, arrowHeight/2.0)];
                [rectanglePath addLineToPoint: CGPointMake(arrowWidth-lineHalfWidth, arrowHeight-lineHalfWidth)];

                break;
                
            case HqArrowImagePositionBottom:
                [rectanglePath moveToPoint: CGPointMake(lineHalfWidth, lineHalfWidth)];
                [rectanglePath addLineToPoint: CGPointMake(arrowWidth/2.0, arrowHeight-lineHalfWidth)];
                [rectanglePath addLineToPoint: CGPointMake(arrowWidth-lineHalfWidth, lineHalfWidth)];

                break;
                
            case HqArrowImagePositionRight:
            {
                [rectanglePath moveToPoint: CGPointMake(lineHalfWidth, lineHalfWidth)];
                [rectanglePath addLineToPoint: CGPointMake(arrowWidth-lineHalfWidth, arrowHeight/2.0)];
                [rectanglePath addLineToPoint: CGPointMake(lineHalfWidth, arrowHeight-lineHalfWidth)];

            }
                
                break;
                
            default:
                break;
        }

        
        if (self.arrowStyle == HqArrowImageStyleFill) {
            [self.arrowColor setFill];
            [rectanglePath fill];
        }else{
            
            rectanglePath.lineWidth = self.lineWidth;

            [self.arrowColor setStroke];
            [rectanglePath stroke];
        }
        arromImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return arromImage;
    
}

+ (UIImage *)navBackImage{
    HqArrowImage *arrowImage = [[HqArrowImage alloc] init];
    arrowImage.imageSize = arrowImage.backIconSize;
    arrowImage.arrowPosition = HqArrowImagePositionLeft;
    return [arrowImage makeImage];
}

+ (UIImage *)tableArrowImage{
    HqArrowImage *arrowImage = [[HqArrowImage alloc] init];
    arrowImage.arrowColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
    return [arrowImage makeImage];
}

+ (UIImage *)questionImage{
    
    UIImage *doneImage = nil;
    
    UIGraphicsBeginImageContextWithOptions((CGSize){20,20}, NO, 0.0f);
    {
        //// Rectangle Drawing
        CGFloat lineWidth = 2.0;
        CGFloat lineHalfWidth = lineWidth/2.0;
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(lineHalfWidth, lineHalfWidth, 18-lineHalfWidth, 18-lineHalfWidth)];
        [UIColor.systemBlueColor setStroke];
        rectanglePath.lineWidth = 1;
        [rectanglePath stroke];
        
        [@"?" drawInRect:CGRectMake(6, 0, 15, 15) withAttributes:@{NSForegroundColorAttributeName:UIColor.systemBlueColor,NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        
        doneImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return doneImage;
}


@end
