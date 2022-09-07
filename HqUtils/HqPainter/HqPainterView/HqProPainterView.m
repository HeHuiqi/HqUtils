//
//  HqProPainterView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqProPainterView.h"
@interface HqProPainterView()

@property(nonatomic,strong) HqPath *currentPath;
@property(nonatomic,strong) CAShapeLayer *currentLayer;

@end

@implementation HqProPainterView

- (NSArray *)addedLayers{
    return self.showLayer.sublayers;
}
- (NSMutableArray *)removeLayers{
    if (!_removeLayers) {
        _removeLayers = @[].mutableCopy;
    }
    return _removeLayers;
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
    self.currentStep = 1;
    self.lineWidth = 5;
    self.strokeColor = [UIColor redColor];
    [self.layer addSublayer:self.showLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    self.currentLayer = [CAShapeLayer layer];
    self.currentPath = [HqPath bezierPath];
    self.currentPath.q_strokeColor = self.strokeColor;
    self.currentPath.lineWidth = self.lineWidth;
    UITouch *touch = [touches anyObject];
    CGPoint start_p = [touch locationInView:self];
    [self.currentPath moveToPoint:start_p];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint line_p = [touch locationInView:self];
    [self.currentPath addLineToPoint:line_p];
    [self refreshPaintboard];

}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint line_p = [touch locationInView:self];
    [self.currentPath addLineToPoint:line_p];
    
    self.currentStep += 1;
    [self refreshPaintboard];
    
    self.toolBar.undoBtn.enabled = self.addedLayers.count > 0;
    self.toolBar.redoBtn.enabled = self.removeLayers.count > 0;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.showLayer.frame = self.bounds;
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
- (void)refreshPaintboard{

    [self refreshLayers];
    
}
- (BOOL)saveToFile{
    if (self.addedLayers.count > 1) {
        return [HqPaintFileManager savePaint:self.showLayer];
    }
    return NO;
}

- (void)loadLayers:(NSArray<CAShapeLayer *> *)layers{
    
    self.currentStep = 1;
    [self.removeLayers removeAllObjects];
    
    NSArray *oldLayers = [self.addedLayers copy];
  

    [layers enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull layer, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *subLayer = [CAShapeLayer layer];
        subLayer.strokeColor = layer.strokeColor;
        subLayer.fillColor = layer.fillColor;
        subLayer.lineWidth = layer.lineWidth;
        subLayer.path = layer.path;
        [self.showLayer addSublayer:subLayer];
        self.currentStep += 1;
    }];

    self.toolBar.undoBtn.enabled = self.addedLayers.count > 0;
    self.toolBar.redoBtn.enabled = self.removeLayers.count > 0;
    
    [oldLayers enumerateObjectsUsingBlock:^(CAShapeLayer  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
 
}
- (void)drawOptType:(NSInteger)optType{
    [self updateLayersWithType:optType];

}
- (void)updateLayersWithType:(NSInteger)optType{

    switch (optType) {
        case 1:
        {
            CAShapeLayer *lastLayer = self.addedLayers.lastObject;
            if (lastLayer) {
                [lastLayer removeFromSuperlayer];
                [self.removeLayers addObject:lastLayer];
                self.currentStep -= 1;
            }
        }
            break;
        case 2:
        {
            CAShapeLayer *lastLayer = self.removeLayers.lastObject;
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
    self.toolBar.undoBtn.enabled = self.addedLayers.count > 0;
    self.toolBar.redoBtn.enabled = self.removeLayers.count > 0;
}

@end


