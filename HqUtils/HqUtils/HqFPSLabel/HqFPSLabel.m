//
//  HqFPSLabel.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/30.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqFPSLabel.h"

@implementation HqWeakProxy

- (instancetype)initWithTarget:(id<NSObject>)target
{
    self = [super init];
    if (self) {
        self.target = target;
    }
    return self;
}
- (BOOL)respondsToSelector:(SEL)aSelector{
    
    return [self.target respondsToSelector:aSelector] || [super respondsToSelector:aSelector];
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    return self.target;
}

@end

@implementation HqFPSLabel
- (CGSize)defaultSize{
    return CGSizeMake(55, 20);
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (frame.size.width == 0 && frame.size.height == 0) {
            CGRect selfFrame = self.frame;
            selfFrame.size = self.defaultSize;
            self.frame = selfFrame;
        }
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.qFont = [UIFont fontWithName:@"Menlo" size:14];
        self.subFont = [UIFont fontWithName:@"Menlo" size:14];
        HqWeakProxy *weakProxy = [[HqWeakProxy alloc] initWithTarget:self];
        self.link = [CADisplayLink displayLinkWithTarget:weakProxy selector:@selector(link:)];
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}
- (void)dealloc
{
    [self.link invalidate];
}
- (void)link:(CADisplayLink *)link{
    if (self.lastTime == 0) {
        self.lastTime = link.timestamp;
        return;
    }
    self.count += 1;
    NSTimeInterval timePassed = link.timestamp - self.lastTime;
    if (timePassed < 1) {
        return;
    }
    self.lastTime = link.timestamp;
    CGFloat fps = self.count / timePassed;
    self.count = 0;
    
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSInteger showFps = (NSInteger)round(fps);
    NSString *showText = [NSString stringWithFormat:@"%@ FPS",@(showFps)];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:showText];
    NSRange range = NSMakeRange(0, text.length-3);
    [text addAttribute:NSForegroundColorAttributeName value:color range:range];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length-3, 3)];
    [text addAttribute:NSFontAttributeName value:self.qFont range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:self.subFont range:NSMakeRange(text.length - 4, 1)];

    self.attributedText = text;
    
}
+ (void)showFPSInView:(UIView * _Nullable)view{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    CGRect rect = [UIApplication sharedApplication].statusBarFrame;
    CGFloat y = CGRectGetHeight(rect);
    HqFPSLabel *lab = [[HqFPSLabel alloc] initWithFrame:CGRectMake(10, y, 0, 0)];
    [view addSubview:lab];
    
}

@end
