//
//  HqPullZoomView.m
//  GlobalPay
//
//  Created by hqmac on 2018/8/23.
//  Copyright © 2018年 hhq. All rights reserved.
//

#import "HqPullZoomView.h"

#define HqKeyPathContentOffset @"contentOffset"
@interface HqPullZoomView ()

@property(nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,assign) BOOL isAdd;
@property (nonatomic,strong)  CAShapeLayer *masklayer;
@property (nonatomic,strong) CAGradientLayer *gradientLaye;

@end

@implementation HqPullZoomView
- (void)dealloc{
    [self removeObservers];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.initY = frame.origin.y;
        self.initHeight = frame.size.height;
        [self setup];
    }
    return self;
}
- (void)setup{
    self.layer.masksToBounds = YES;
    [self addSubview:self.bgImageView];
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}
- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    if (_scrollView) {
        [self addObservers];
    }
}

#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:HqKeyPathContentOffset options:options context:nil];
}

- (void)removeObservers
{
    [self.scrollView removeObserver:self forKeyPath:HqKeyPathContentOffset];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:HqKeyPathContentOffset]) {
        NSValue *offset = (NSValue *)(change[NSKeyValueChangeNewKey]);
        CGFloat offsetY = offset.CGPointValue.y;
        CGRect rect = self.frame;
        if (offsetY<0) {
            rect.origin.y = self.initY;
            rect.size.height = self.initHeight-offsetY;
        }else{
            CGFloat y = self.initY-offsetY;
            rect.origin.y = y;
        }
        self.frame = rect;

    }
}
- (void)setBgImage:(UIImage *)bgImage{
    _bgImage = bgImage;
    if (_bgImage) {
        self.bgImageView.image  = bgImage;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgImageView.frame = self.bounds;
    [self addArcWithView:self];

}
- (void)addArcWithView:(UIView *)view{
    CGFloat width = view.bounds.size.width;
    CGFloat height = view.bounds.size.height;
    
    CAShapeLayer *masklayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat radius = width*2;
    CGFloat centerY = - (radius-height);
    CGFloat centerX = width/2.0;
    [path moveToPoint:CGPointMake(centerX, centerY)];
    [path addArcWithCenter:CGPointMake(centerX, centerY) radius:radius startAngle:0 endAngle:M_PI clockwise:YES];

    masklayer.strokeColor = [UIColor whiteColor].CGColor;
    masklayer.fillColor = [UIColor redColor].CGColor;
    masklayer.path = path.CGPath;
    view.layer.mask = masklayer;
}
- (CALayer *)addBackgroudlayer:(CGRect)bounds colors:(NSArray *)colors{
    
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    
    CAShapeLayer *masklayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat radius = width*2;
    CGFloat centerY = - (radius-height);
    CGFloat centerX = width/2.0;
    [path moveToPoint:CGPointMake(centerX, centerY)];
    [path addArcWithCenter:CGPointMake(centerX, centerY) radius:radius startAngle:0 endAngle:M_PI clockwise:YES];
    masklayer.path = path.CGPath;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
   
    NSMutableArray *cgColors = [[NSMutableArray alloc] init];
    for (UIColor *color  in colors) {
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    gradientLayer.colors = cgColors;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = bounds;
    gradientLayer.mask = masklayer;

    return gradientLayer;

}

- (UIImage *)createImageWithGradientcolors:(NSArray *)colros rect:(CGRect)rect{
    UIView *bgView = [[UIView alloc] initWithFrame:rect];
    bgView.backgroundColor = [UIColor clearColor];
    return [self convertViewToImage:bgView colors:colros];
}
-(UIImage*)convertViewToImage:(UIView*)v colors:(NSArray *)colors{
    
    CGSize s = v.bounds.size;
    CALayer *layer = [self addBackgroudlayer:v.bounds colors:colors];
    [v.layer addSublayer:layer];
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
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

