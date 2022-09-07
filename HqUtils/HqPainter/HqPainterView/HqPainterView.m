//
//  HqPainterView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/30.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqPainterView.h"

@interface HqPainterView()

@property(nonatomic,strong) HqPath *currentPath;
@property(nonatomic,strong) CAShapeLayer *currentLayer;

@end



@implementation HqPainterView
- (NSMutableArray *)subPaths{
    if (!_subPaths) {
        _subPaths = @[].mutableCopy;
    }
    return _subPaths;
}
- (NSMutableArray *)removeLayers{
    if (!_removeLayers) {
        _removeLayers = @[].mutableCopy;
    }
    return _removeLayers;
}
- (NSMutableArray *)undoPaths{
    if (!_undoPaths) {
        _undoPaths = @[].mutableCopy;
    }
    return _undoPaths;
}

- (CAShapeLayer *)showLayer{
    if (!_showLayer) {
        _showLayer = [CAShapeLayer layer];
        _showLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _showLayer;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.accrossLayerDraw = YES;
    self.currentStep = 1;
    self.lineWidth = 5;
    self.strokeColor = [UIColor redColor];
    [self.layer addSublayer:self.showLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.currentPath = [HqPath bezierPath];
    self.currentLayer = [CAShapeLayer layer];
    self.currentPath.q_strokeColor = self.strokeColor;
    self.currentPath.lineWidth = self.lineWidth;
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
        CGPoint start_p = [obj locationInView:self];
        [self.currentPath moveToPoint:start_p];
    }];
    if (![self.subPaths containsObject:self.currentPath]) {
        [self.subPaths addObject:self.currentPath];
    }
    [self removeLayers];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
        CGPoint line_p = [obj locationInView:self];
        [self.currentPath addLineToPoint:line_p];
    }];
    [self refreshPaintboard];

}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
        CGPoint line_p = [obj locationInView:self];
        [self.currentPath addLineToPoint:line_p];
    }];
    self.currentStep += 1;
    
    [self refreshPaintboard];
    if (self.accrossLayerDraw) {
        self.toolBarView.undoBtn.enabled = self.showLayer.sublayers.count > 0;
        self.toolBarView.redoBtn.enabled = self.removeLayers.count > 0;
    }else{
        self.toolBarView.undoBtn.enabled = self.subPaths.count > 0;
        self.toolBarView.redoBtn.enabled = self.undoPaths.count > 0;
    }

}
- (void)refreshLayers{

    CAShapeLayer *layer = self.currentLayer;
    HqPath *sub_path = self.currentPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = sub_path.q_strokeColor.CGColor;
    layer.lineWidth = sub_path.lineWidth;
    layer.path = sub_path.CGPath;
    [self.showLayer addSublayer:layer];
}
- (void)sampleLayerRefresh{
    NSInteger count = self.subPaths.count;
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < count; i++) {
        HqPath *sub_path = self.subPaths[i];
        self.showLayer.strokeColor = sub_path.q_strokeColor.CGColor;
        self.showLayer.lineWidth = sub_path.lineWidth;
        [path appendPath:sub_path];

    }
    self.showLayer.path = path.CGPath;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.showLayer.frame = self.bounds;
}
- (void)refreshPaintboard{
//    [self setNeedsDisplay];
//    [self sampleLayerRefresh];
    if (self.accrossLayerDraw) {
        [self refreshLayers];

    }else{
        [self setNeedsDisplay];
    }
    
    
}

- (void)drawOptType:(NSInteger)optType{
    if (self.accrossLayerDraw) {
        [self updateLayersWithType:optType];
    }else{
        [self updateRedrawWithType:optType];
    }
}
- (void)updateLayersWithType:(NSInteger)optType{

    switch (optType) {
        case 1:
        {
            CAShapeLayer *lastLayer = self.showLayer.sublayers.lastObject;
            NSLog(@"self.showLayer.sublayers==%@",self.showLayer.sublayers);
            if (lastLayer) {
                [lastLayer removeFromSuperlayer];
                [self.removeLayers addObject:lastLayer];
            }
            
        }
            break;
        case 2:
        {
            CAShapeLayer *lastLayer = self.removeLayers.lastObject;
            NSLog(@"self.removeLayers==%@",self.removeLayers);

            if (lastLayer) {
                [self.showLayer addSublayer:lastLayer];
                [self.removeLayers removeObject:lastLayer];
                self.currentStep += 1;

            }
        }
            break;
            
            
        default:
            break;
    }
    self.toolBarView.undoBtn.enabled = self.showLayer.sublayers.count > 0;
    self.toolBarView.redoBtn.enabled = self.removeLayers.count > 0;
}


- (void)updateRedrawWithType:(NSInteger)optType{
    NSMutableArray *subPaths = self.subPaths;
    NSMutableArray *undoPaths = self.undoPaths;
    switch (optType) {
        case 1:
        {
            UIBezierPath *path = subPaths.lastObject;
            if (subPaths.count > 0) {
                [undoPaths addObject:path];
                [subPaths removeObject:path];
                self.currentStep -= 1;
            }
        }
            break;
        case 2:
        {
            if (undoPaths.count > 0) {
                UIBezierPath *path = undoPaths.lastObject;
                [subPaths addObject:path];
                [undoPaths removeObject:path];
                self.currentStep += 1;

            }
        }
            break;
            
            
        default:
            break;
    }
    [self refreshPaintboard];
    self.toolBarView.undoBtn.enabled = subPaths.count > 0;
    self.toolBarView.redoBtn.enabled = undoPaths.count > 0;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.accrossLayerDraw) {
        NSInteger count = self.subPaths.count;
        for (int i = 0; i < count; i++) {
            HqPath *sub_path = self.subPaths[i];
            UIColor *color = sub_path.q_strokeColor;
            [self setPathStrokeColor:color path:sub_path];
        }
    }

}


- (void)setPathStrokeColor:(UIColor *)color path:(UIBezierPath *)path{
    [color set];
    [path stroke];
    UIColor *fillColor = [UIColor clearColor];
    [fillColor set];
    [path fill];
}

- (NSArray *)pathPoints:(CGPathRef)path{
    
    NSMutableArray *points = @[].mutableCopy;
    
    CGPathApply(path, (__bridge void * _Nullable)(points), myCGPathApplierFunction);
    //    NSLog(@"points==%@",points);
    return points;
}
void myCGPathApplierFunction(void *info, const CGPathElement *element){
    //会多次调用这个方法
    NSMutableArray *points = (__bridge NSMutableArray *)(info);
    switch(element->type) {
            
        case kCGPathElementMoveToPoint: // contains 1 point
        {
            [points addObject:@(element->points[0])];
            
        }
            break;
        case kCGPathElementAddLineToPoint: // contains 1 point
            
        {
            [points addObject:@(element->points[0])];
        }
            break;
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            
        {
            [points addObject:@(element->points[0])];
            
            [points addObject:@(element->points[1])];
        }
            
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            
        {
            [points addObject:@(element->points[0])];
            
            [points addObject:@(element->points[1])];
            
            [points addObject:@(element->points[2])];
        }
            
            break;
            
            
        case kCGPathElementCloseSubpath: // contains no point
            
            break;
            
    }
}


@end


