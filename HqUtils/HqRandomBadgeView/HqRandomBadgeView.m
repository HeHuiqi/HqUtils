//
//  HqRandomBtnView.m
//  HqUtils
//
//  Created by hehuiqi on 8/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqRandomBadgeView.h"

@interface HqRandomBadgeView ()<CAAnimationDelegate>

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) UIView *tempView;



@end

@implementation HqRandomBadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.badgeImage = [UIImage imageNamed:@"pingguo"];
        [self setup];
    }
    return self;
}
- (NSInteger)randomIndex{
    int x = arc4random() % 24;
    return x;
}
- (void)setup{

    self.btns = [[NSMutableArray alloc] init];
    int k = 0;
    CGFloat w = self.bounds.size.width/6.0;
    CGFloat h = 60;
    for (int i = 0; i<24; i++) {
        HqRandomBtn *btn = [[HqRandomBtn alloc] init];
        btn.hidden  = YES;
        CGFloat x = i%6*w;
        CGFloat y = i/6*h;
        btn.tag = k;
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitle:@(k).stringValue forState:UIControlStateNormal];
        [self addSubview:btn];
        [self.btns addObject:btn];
        [btn setBackgroundImage:self.badgeImage forState:UIControlStateNormal];
        
        [btn setTitle:@(i).stringValue forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self changeCenterWithBtn:btn];
        [self animationUpDownWithView:btn];
    }
    
}
- (void)setDatas:(NSMutableArray<HqRandomModel *> *)datas{
    _datas = datas;
    if (_datas.count>0) {
        for (HqRandomBtn *btn  in self.btns) {
            btn.hidden = YES;
        }
        for (int i = 0; i<datas.count; i++) {
            [self showBtnWithModel:datas[i]];
        }
       
    }
}
- (void)changeCenterWithBtn:(HqRandomBtn *)btn{
    CGSize size  = btn.bounds.size;
    CGFloat w = size.width;
    CGFloat h = size.height;
    CGFloat vw = self.bounds.size.width;
    CGFloat vh = self.bounds.size.height;
    int x1 = arc4random() %(int)(size.width/2.0);
    int y1  = arc4random() %(int)(size.height/2.0);
    CGPoint  center = btn.center;
    CGFloat randomX = center.x+x1;
    CGFloat randomY = center.y + y1;
    if (randomX+w > vw) {
        randomX = center.x-x1;
    }
    if (randomY+h>vh) {
        randomY = center.y-y1;
    }
    center.x = randomX;
    center.y = randomY;
    btn.center = center;
}

- (void)showBtnWithModel:(HqRandomModel *)model{
    NSInteger index = [self randomIndex];
    HqRandomBtn *btn = self.btns[index];
    if (btn.hidden == YES) {
        btn.hidden = NO;
        btn.randomModel = model;
    }else{
        [self showBtnWithModel:model];
    }
}
- (void)btnClick:(HqRandomBtn *)btn{
    [self hideBtn:btn];

}

- (void)animationUpDownWithView:(UIView *)view{
    
    CALayer *viewLayer = view.layer;
    [viewLayer removeAllAnimations];
    
    CGPoint position = viewLayer.position;
    CGPoint fromPoint = CGPointMake(position.x, position.y);
    CGPoint toPoint = CGPointZero;
    
    uint32_t typeInt = arc4random() % 100;
    CGFloat distanceFloat = 0.0;
    while (distanceFloat == 0) {
        distanceFloat = (6 + (int)(arc4random() % (9 - 7 + 1))) * 100.0 / 101.0;
    }
    if (typeInt % 2 == 0) {
        toPoint = CGPointMake(position.x, position.y - distanceFloat);
    } else {
        toPoint = CGPointMake(position.x, position.y + distanceFloat);
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.autoreverses = YES;
    CGFloat durationFloat = 0.0;
    while (durationFloat == 0.0) {
        durationFloat = 0.9 + (int)(arc4random() % (100 - 70 + 1)) / 31.0;
    }
    [animation setDuration:durationFloat];
    [animation setRepeatCount:MAXFLOAT];
    
    [viewLayer addAnimation:animation forKey:nil];
}
- (void)hideBtn:(HqRandomBtn *)randomBtn
{
    /*
    [UIView animateWithDuration:0.3 animations:^{
        randomBtn.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        randomBtn.hidden = YES;
        randomBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [self.datas removeObject:randomBtn.randomModel];
        if (self.datas.count == 0) {
            if (self.delegate) {
                [self.delegate randomBadgeViewDeleteAllWithView:self];
            }
        }else{
            if (self.delegate) {
                [self.delegate randomBadgeView:self didSelectedModel:randomBtn.randomModel];
            }
        }
    }];
    */
//    [self animationDownWithView:randomBtn];
    [self animationKeyFrameDownWithView:randomBtn];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.datas removeObject:randomBtn.randomModel];
        if (self.datas.count == 0) {
            if (self.delegate) {
//                [self.delegate randomBadgeViewDeleteAllWithView:self];
                [self.delegate randomBadgeView:self deleteAllModel:randomBtn.randomModel];
            }
        }else{
            if (self.delegate) {
                [self.delegate randomBadgeView:self didSelectedModel:randomBtn.randomModel];
            }
        }
    });
   
}

- (void)animationDownWithView:(HqRandomBtn *)view{
    
    
    self.tempView = view;
    CGPoint position = view.layer.position;
    CGPoint fromPoint = CGPointMake(position.x, position.y);
    CGPoint toPoint = CGPointZero;
    
    CGFloat distanceFloat = -100;
    toPoint = CGPointMake(position.x, position.y + distanceFloat);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    
    
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.5;
//    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:@[animation,showViewAnn]];
    [view.layer addAnimation:group forKey:@"group_down"];
    
}

- (void)animationKeyFrameDownWithView:(HqRandomBtn *)view{

    self.tempView = view;

    CGPoint position = view.layer.position;
    CGPoint fromPoint = CGPointMake(position.x, position.y);
    CGPoint toPoint = CGPointZero;
    
    CGFloat distanceFloat = -100;
    toPoint = CGPointMake(position.x, position.y + distanceFloat);
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
//    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CGPoint startPoint = fromPoint;
    CGPoint endPoint =  CGPointMake(40, self.bounds.size.height+30);
    CGPoint controlPoint = CGPointMake(endPoint.x,startPoint.y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:view.center];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    animation.path = path.CGPath;
    
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.5;
        group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:@[animation,opacityAnimation]];
    [view.layer addAnimation:group forKey:@"group_down"];

    
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    
    self.tempView.hidden = YES;
    [self.tempView.layer removeAllAnimations];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
