//
//  HqFoldLineView.m
//  GlobalPay
//
//  Created by hqmac on 2018/8/30.
//  Copyright © 2018年 solar. All rights reserved.
//

#import "HqFoldLineView.h"
#import "HqQipaoView.h"
#import "UIBezierPath+curved.h"
@interface HqFoldLineView()

@property (nonatomic,strong) HqQipaoView *qipaoView;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;

@property (nonatomic,strong) CAShapeLayer *dashLayer;

@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) CAShapeLayer *touchLineLayer;

@property (nonatomic,assign) CGFloat lineWidth;

@property(nonatomic,strong) UILabel *touchShowPriceLab;
@property(nonatomic,strong) UIView *touchShowCircle;
@property(nonatomic,strong) UIView *touchShowData;


@end
@implementation HqFoldLineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    self.datas = [[NSMutableArray alloc] init];
    self.lineWidth = LineHeight;

    [self.layer addSublayer:self.gradientLayer];
    [self.layer addSublayer:self.lineLayer];
    [self.layer addSublayer:self.touchLineLayer];
    [self.layer addSublayer:self.dashLayer];
    [self addSubview:self.touchShowPriceLab];
    [self addSubview:self.touchShowCircle];
    self.gradientLayer.mask = [CAShapeLayer layer];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapGesture:)];
    [self addGestureRecognizer:longTap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:pan];
}
#pragma mark - longPressGesture
- (void)panGesture:(UIPanGestureRecognizer *)pan{
    [self dealGesture:pan];
}
#pragma mark - Tap
- (void)longTapGesture:(UILongPressGestureRecognizer*)longTap
{
    [self dealGesture:longTap];
}
- (UILabel *)touchShowPriceLab{
    if (!_touchShowPriceLab) {
        _touchShowPriceLab = [[UILabel alloc] init];
        _touchShowPriceLab.textColor = [UIColor blueColor];
        _touchShowPriceLab.hidden = YES;
        _touchShowPriceLab.font = SetFont(kZoomValue(13));
        _touchShowPriceLab.lineBreakMode = NSLineBreakByClipping;
    }
    return _touchShowPriceLab;
}
- (UIView *)touchShowCircle{
    if (!_touchShowCircle) {
        _touchShowCircle = [[UIView alloc] init];
        _touchShowCircle.bounds = CGRectMake(0, 0, 12, 12);
        _touchShowCircle.layer.cornerRadius = 6;
        _touchShowCircle.backgroundColor = [UIColor yellowColor];
        _touchShowCircle.clipsToBounds = YES;
        _touchShowCircle.hidden = YES;
    }
    return _touchShowCircle;
}
- (void)setDatas:(NSMutableArray *)datas{
    _datas = datas;
    if (_datas) {
        if (_datas.count>0) {
            self.qipaoView.hidden = YES;
            self.touchLineLayer.path = nil;
            [self refreshTrendLayer];
        }
    }
}
#pragma mark - 刷新视图
- (void)refreshTrendLayer{
    UIBezierPath *path = [self drawLine:self.datas];
    path = [path smoothedPathWithGranularity:30];
    self.lineLayer.path = path.CGPath;
    [self drawGradientWithPath:path];
}
#pragma mark - 绘制虚线
- (void)drawDashLineLayer{
    
    CGFloat dashLineW = self.bounds.size.width;
    CGFloat lineSpace = (self.bounds.size.height-3*self.lineWidth)/3;
    
    UIBezierPath *dashPath = [UIBezierPath bezierPath];
    [dashPath moveToPoint:CGPointMake(0, 0)];
    [dashPath addLineToPoint:CGPointMake(dashLineW, 0)];
    
    [dashPath moveToPoint:CGPointMake(0, lineSpace)];
    [dashPath addLineToPoint:CGPointMake(dashLineW, lineSpace)];
    
    [dashPath moveToPoint:CGPointMake(0, lineSpace*2)];
    [dashPath addLineToPoint:CGPointMake(dashLineW, lineSpace*2)];
    
    [dashPath moveToPoint:CGPointMake(0, lineSpace*3)];
    [dashPath addLineToPoint:CGPointMake(dashLineW, lineSpace*3)];
    
    self.dashLayer.path = dashPath.CGPath;
    
    
}
#pragma mark 渐变阴影
- (void)drawGradientWithPath:(UIBezierPath *)path{
    HqPointModel *last = self.datas.lastObject;
    [path addLineToPoint:CGPointMake(last.xPosition, kZoomValue(200))];
    [path addLineToPoint:CGPointMake(0, kZoomValue(200))];
    [path closePath];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = path.CGPath;
    self.gradientLayer.mask = mask;
    
}
- (CAShapeLayer *)lineLayer{
    if (!_lineLayer) {
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.lineWidth = self.lineWidth;
        _lineLayer.strokeColor = [UIColor blueColor].CGColor;
        _lineLayer.fillColor = [UIColor clearColor].CGColor;
        _lineLayer.contentsScale = [UIScreen mainScreen].scale;
      
    }
    return _lineLayer;
}
- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    }
    return _gradientLayer;
}
- (CAShapeLayer *)dashLayer{
    if (!_dashLayer) {
        _dashLayer = [CAShapeLayer layer];
        _dashLayer.lineDashPattern = @[@6, @10];
        _dashLayer.lineWidth = LineHeight;
        UIColor *strokeColor = LineColor;
        _dashLayer.strokeColor = strokeColor.CGColor;
    }
    return _dashLayer;
}
- (CAShapeLayer *)touchLineLayer{
    if (!_touchLineLayer) {
        _touchLineLayer = [CAShapeLayer layer];
        _touchLineLayer.lineWidth = self.lineWidth;
        _touchLineLayer.strokeColor = [UIColor blueColor].CGColor;
        _touchLineLayer.fillColor = [UIColor whiteColor].CGColor;
        _touchLineLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _touchLineLayer;
}

- (void)dealGesture:(UIGestureRecognizer *)gesture{
    CGPoint location = [gesture locationInView:self];
    
    HqPointModel *touchModel = [self findMixSpaceWithXPostion:location.x];
    if (touchModel) {
        [self addIndicatorViewWithModel:touchModel];
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
//        self.touchShowPriceLab.hidden = YES;
        self.touchLineLayer.hidden = YES;
        self.touchShowCircle.hidden = YES;
        if ([self.delegate respondsToSelector:@selector(hqFoldLineViewTouchEndDismiss:)] && self.delegate) {
            [self.delegate hqFoldLineViewTouchEndDismiss:self];
        }
    }
}
- (void)addIndicatorViewWithModel:(HqPointModel *)touchModel{

//    self.touchShowPriceLab.hidden = NO;
    self.touchLineLayer.hidden = NO;
    self.touchShowCircle.hidden = NO;
    
//    self.touchShowPriceLab.text =  [NSString stringWithFormat:@"%@",@(touchModel.kLinemodel.close)];
//    self.touchShowPriceLab.mj_y = touchModel.yPosition-6;
    
    self.touchShowCircle.center = CGPointMake(touchModel.xPosition, touchModel.yPosition);
    
    UIBezierPath *touchLinePath = [UIBezierPath bezierPath];
    [touchLinePath moveToPoint:CGPointMake(touchModel.xPosition, touchModel.yPosition)];
    [touchLinePath addLineToPoint:CGPointMake(touchModel.xPosition, self.bounds.size.height)];
    [touchLinePath moveToPoint:CGPointMake(0, touchModel.yPosition)];
    [touchLinePath addLineToPoint:CGPointMake(self.bounds.size.width, touchModel.yPosition)];
  
    if ([self.delegate respondsToSelector:@selector(hqFoldLineView:touchBeginShowPointModel:)] && self.delegate) {
        [self.delegate hqFoldLineView:self touchBeginShowPointModel:touchModel];
    }
    self.touchLineLayer.path = touchLinePath.CGPath;
    
}
- (HqPointModel *)findMixSpaceWithXPostion:(CGFloat)xPostion{
    if (xPostion>self.bounds.size.width) {
        return nil;
    }
    if (self.datas.count==0) {
        return nil;
    }
    HqPointModel *lastPoint = self.datas.lastObject;
    if (xPostion >= lastPoint.xPosition){
        return lastPoint;
    }
    
    HqPointModel *firstPoint = self.datas.firstObject;
    if (fabs(xPostion - 0) <= firstPoint.xPosition){
        return firstPoint;
    }
    
    HqPointModel *first  = self.datas.firstObject;
    CGFloat minX = fabs(first.xPosition - xPostion);
    for (HqPointModel *model in self.datas) {
        CGFloat space = fabs(model.xPosition-xPostion);
        if (space < minX) {
            minX = space;
            first = model;
        }
    }
    return first;
}

- (UIBezierPath*)drawLine:(NSArray*)linesArray
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [linesArray enumerateObjectsUsingBlock:^(HqPointModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0){
            [path moveToPoint:CGPointMake(obj.xPosition,obj.yPosition)];
        }else{
            [path addLineToPoint:CGPointMake(obj.xPosition,obj.yPosition)];
        }
    }];
    return path;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.dashLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.dashLayer.frame = self.bounds;
    self.gradientLayer.frame = self.bounds;
    self.touchShowPriceLab.frame = CGRectMake(self.bounds.size.width, 0, 60, 12);

    [self drawDashLineLayer];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
