//
//  HqRefreshFooter.m
//  HqPullRefresh
//
//  Created by hqmac on 2018/11/20.
//  Copyright © 2018 solar. All rights reserved.
//

#import "HqRefreshFooter.h"

@interface HqRefreshFooter()<UIScrollViewDelegate>
@property (nonatomic,assign) CGFloat bottomOffsetY;

@end
@implementation HqRefreshFooter

- (void)dealloc{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:HqContentOffsetKeyPath];
    }
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}
- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    if (_scrollView) {
       
        [_scrollView addSubview:self];
        self.frame = CGRectMake(0, CGRectGetMaxY(_scrollView.frame),_scrollView.bounds.size.width , HqRefreshLoadingY);
        [_scrollView addObserver:self forKeyPath:HqContentOffsetKeyPath options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
}
- (void)setup{
    self.refreshColor = [UIColor colorWithRed:71.0/255.0 green:144.0/255.0 blue:211.0/255.0 alpha:1.0];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.layer addSublayer:self.pathLayer];
    [self addSubview:self.indictatorView];
}
- (void)beginRefreshing{
    self.isRefreshing = YES;
    [self.indictatorView startAnimating];
    if (self.beginLoadingBlock) {
        self.beginLoadingBlock();
    }
}
- (void)beginRefreshingWithBlock:(HqBeginLoadingBlock)block{
    self.beginLoadingBlock = block;
}
- (void)setRefreshColor:(UIColor *)refreshColor{
    _refreshColor = refreshColor;
}
- (void)endRefreshing{
    [self.indictatorView stopAnimating];
    //NSLog(@"bottomOffsetY == %@",@(self.bottomOffsetY));
    [UIView animateWithDuration:0.3 animations:^{
        if (self.bottomOffsetY>=0) {
            [self.scrollView setContentOffset:CGPointMake(0, self.bottomOffsetY)  animated:NO];
        }else{
            [self.scrollView setContentOffset:CGPointMake(0, 0)  animated:NO];
        }

        self.pullScale = 0;
    } completion:^(BOOL finished) {
        
        NSLog(@"动画结束====");
        self.isRefreshing = NO;
    }];
}
- (void)setIsRefreshing:(BOOL)isRefreshing{
    _isRefreshing = isRefreshing;
    self.pathLayer.hidden = _isRefreshing;
}
- (UIActivityIndicatorView *)indictatorView{
    if (!_indictatorView) {
        _indictatorView = [[UIActivityIndicatorView alloc] init];
        _indictatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _indictatorView.color = self.refreshColor;
        CGFloat Y = HqRefreshLoadingY/2.0;
        CGFloat X = [UIScreen mainScreen].bounds.size.width/2.0;
        CGPoint center = CGPointMake(X, Y);
        _indictatorView.center = center;
    }
    
    return _indictatorView;
}
- (CAShapeLayer *)pathLayer{
    if (!_pathLayer) {
        _pathLayer = [CAShapeLayer layer];
        _pathLayer.fillColor = [UIColor clearColor].CGColor;
        _pathLayer.strokeColor = self.refreshColor.CGColor;
        _pathLayer.strokeStart = 0;
        _pathLayer.lineWidth = 2;
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat Y = HqRefreshLoadingY/2.0;
        CGFloat radius = Y-15;
        CGFloat X = [UIScreen mainScreen].bounds.size.width/2.0;
        CGPoint center = CGPointMake(X, Y);
        [path addArcWithCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
        _pathLayer.path = path.CGPath;
        _pathLayer.strokeEnd = 0;
    }
    return _pathLayer;
}
- (void)setPullScale:(CGFloat)pullScale{
    _pullScale = pullScale;
    _pathLayer.strokeEnd = _pullScale;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:HqContentOffsetKeyPath]) {
        [self dealLoadingDidScroll:self.scrollView];
    }
}
- (void)dealLoadingDidScroll:(UIScrollView *)scrollView{
    
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat viewHeight = scrollView.bounds.size.height;
    CGFloat viewWidth = scrollView.bounds.size.width;

    //    NSLog(@"contentHeight= %@",@(contentHeight));
    //    NSLog(@"viewHeight= %@",@(viewHeight));
    CGFloat offsetY = scrollView.contentOffset.y;
    //    NSLog(@"offsetY= %@",@(offsetY));
    //    NSLog(@"contentHeight-viewHeight= %@",@(contentHeight-viewHeight));
    if (self.isRefreshing) {
        return;
    }
    if (offsetY>0) {
        
        CGFloat space = contentHeight-viewHeight;
        
        
        //        NSLog(@"space= %@",@(space));
        
        if (space<=0) {
            //NSLog(@"到底部了-offsetY---%@",@(offsetY));
            CGFloat scale = offsetY/HqRefreshLoadingY;
            self.pullScale = scale;
            if (offsetY>HqRefreshLoadingY) {
                [self dealLoadingWithScrollView:scrollView space:space];
            }
            self.frame = CGRectMake(0, viewHeight, viewWidth, HqRefreshLoadingY);
        }else{
            self.frame = CGRectMake(0, space+viewHeight, viewWidth, HqRefreshLoadingY);

            CGFloat bottomSpace = offsetY-space;
//            NSLog(@"bottomSpace--%@",@(bottomSpace));
            CGFloat scale = bottomSpace/HqRefreshLoadingY;
//            NSLog(@"scale == %@",@(scale));
            self.pullScale = scale;
            
            if (bottomSpace>HqRefreshLoadingY) {
                //NSLog(@"到底部了--bottomSpace--%@",@(bottomSpace));
                [self dealLoadingWithScrollView:scrollView space:space];
                
            }
        }
    }
}
- (void)dealLoadingWithScrollView:(UIScrollView *)scrollView space:(CGFloat)space{
    if (!scrollView.dragging) {
        self.bottomOffsetY = space;

        [UIView animateWithDuration:0.3 animations:^{
            if (space<0) {
                [scrollView setContentOffset:CGPointMake(0, HqRefreshLoadingY) animated:NO];
            }else{
                [scrollView setContentOffset:CGPointMake(0, space+HqRefreshLoadingY) animated:NO];
            }
            
        } completion:^(BOOL finished) {
            [self beginRefreshing];
        }];
        /*
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endRefreshing];
        });
        */
    }else{

    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
