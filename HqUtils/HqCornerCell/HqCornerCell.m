//
//  HqCornerCell.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/23.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqCornerCell.h"



@implementation HqCornerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.hidden = YES;
        self.bgLayerBorderWidth = (1.0f / [UIScreen mainScreen].scale);
        [self setup];
    }
    return self;
}
- (void)setup{
//    [self.layer addSublayer:self.shadowLayer];
//    [self.layer addSublayer:self.bgLayer];

    
    [self hqLayoutSubviews];
}
- (void)hqLayoutSubviews{
    
}
- (CAShapeLayer *)bgLayer{
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.fillColor = [UIColor whiteColor].CGColor;
//        _bgLayer.strokeColor = [UIColor darkGrayColor].CGColor;
//        _bgLayer.lineWidth = self.bgLayerBorderWidth;
        _bgLayer.contentsScale = [UIScreen mainScreen].scale;

        _bgLayer.shadowOpacity = 1.0;
        _bgLayer.shadowOffset = CGSizeMake(1, 1);
    }
    return _bgLayer;
}
- (CAShapeLayer *)shadowLayer{
    if (!_shadowLayer) {
        _shadowLayer = [CAShapeLayer layer];
        _shadowLayer.shadowOpacity = 1.0;
        _shadowLayer.shadowOffset = CGSizeMake(1, 1);
        _shadowLayer.backgroundColor = [UIColor yellowColor].CGColor;
    }
    return _shadowLayer;;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    
//    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
//    bgView.clipsToBounds = YES;
//    bgView.backgroundColor = [UIColor whiteColor];
//    self.backgroundView = bgView;
//
//    CGRect  bgLayerRect = CGRectMake(10, 0, self.bounds.size.width-20, self.bounds.size.height);
////    self.bgLayer.masksToBounds = YES;
////    self.shadowLayer.frame = bgLayerRect;
//    UIRectCorner rectCorner = UIRectCornerTopLeft|UIRectCornerTopRight;
//    UIBezierPath *path = nil;
//    CGFloat corner = 10;
//    switch (self.cornetPosition) {
//        case HqCornetPositionAll:
//        {
//            rectCorner = UIRectCornerAllCorners;
//            path = [UIBezierPath bezierPathWithRoundedRect:bgLayerRect byRoundingCorners:rectCorner cornerRadii:CGSizeMake(corner, corner)];
//
//
//        }
//            break;
//        case HqCornetPositionCenter:
//        {
//            path = [UIBezierPath bezierPathWithRect:bgLayerRect];
//
//        }
//            break;
//            
//        case HqCornetPositionTop:
//        {
//            rectCorner =  UIRectCornerTopLeft|UIRectCornerTopRight;
//            path = [UIBezierPath bezierPathWithRoundedRect:bgLayerRect byRoundingCorners:rectCorner cornerRadii:CGSizeMake(corner, corner)];
//
//
//        }
//            break;
//        case HqCornetPositionBottom:
//        {
//            rectCorner = UIRectCornerBottomRight|UIRectCornerBottomLeft;
//            path = [UIBezierPath bezierPathWithRoundedRect:bgLayerRect byRoundingCorners:rectCorner cornerRadii:CGSizeMake(corner, corner)];
//
//        }
//            break;
//        default:
//            break;
//    }
//    UIBezierPath *shadowPath = path;
//
//    NSLog(@"bgLayerBorderWidth==%@",@(self.bgLayerBorderWidth));
//    self.bgLayer.path = path.CGPath;
//    self.bgLayer.shadowPath = shadowPath.CGPath;
//    [self.backgroundView.layer addSublayer:self.bgLayer];
//    
//}


@end
