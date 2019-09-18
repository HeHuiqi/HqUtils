//
//  HqShortArticleLineView.m
//  HqUtils
//
//  Created by hehuiqi on 7/2/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqShortArticleLineView.h"

@interface HqShortArticleLineView ()

@property (nonatomic,strong) CAShapeLayer *dashLineLayer;


@end

@implementation HqShortArticleLineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    [self.layer addSublayer:self.dashLineLayer];
}

- (CAShapeLayer *)dashLineLayer{
    if (!_dashLineLayer) {
        _dashLineLayer = [CAShapeLayer layer];
        _dashLineLayer.lineDashPattern = @[@(3),@(4)];
        _dashLineLayer.strokeColor = LineColor.CGColor;
        _dashLineLayer.lineWidth = 1.0;
        _dashLineLayer.fillColor = [UIColor redColor].CGColor;
        _dashLineLayer.contentsScale  = [UIScreen mainScreen].scale;
    }
    return _dashLineLayer;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, 0)];
    [linePath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    self.dashLineLayer.path = linePath.CGPath;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
