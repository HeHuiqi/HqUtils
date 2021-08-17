//
//  HqCloseImage.m
//  HqUtils
//
//  Created by hehuiqi on 2021/5/28.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqCloseImage.h"

@implementation HqCloseImage
- (instancetype)init{
    if (self = [super init]) {
        _imageSize = CGSizeMake(18.0, 18.0);
        _closeColor = [UIColor systemBlueColor];
        _lineWidth = 1.5;
    }
    return self;
}
- (UIImage *)makeImage{
    
    UIImage *doneImage = nil;
    CGFloat lineWidth = self.lineWidth;
    CGFloat doubleLineWidth = lineWidth*2;

    
    CGFloat imageW = self.imageSize.width;
    CGFloat imageH = self.imageSize.height;
    
    CGFloat circleWidth = sqrt(imageW*imageW*2);
    CGSize targetSize = CGSizeMake(circleWidth, circleWidth);
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0f);
    {


        if (self.closeStyle == HqCloseImageStyleHaveCircleBorder) {
            UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(lineWidth, lineWidth, circleWidth-doubleLineWidth,circleWidth-doubleLineWidth)];
            [self.closeColor setStroke];
            circlePath.lineWidth = lineWidth;
            [circlePath stroke];
        }

        
        CGFloat space = (circleWidth - imageW)/2.0+lineWidth;
        
        UIBezierPath* linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(space, space)];
        [linePath addLineToPoint:CGPointMake(imageW+space-doubleLineWidth, imageH+space-doubleLineWidth)];
        [linePath moveToPoint:CGPointMake(space, imageH+space-doubleLineWidth)];
        [linePath addLineToPoint:CGPointMake(imageW+space-doubleLineWidth, space)];
        
        [self.closeColor setStroke];
        linePath.lineWidth = lineWidth;
        [linePath stroke];
        doneImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return doneImage;
}


@end
