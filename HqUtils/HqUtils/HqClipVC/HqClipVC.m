//
//  HqClipVC.m
//  HqUtils
//
//  Created by hqmac on 2019/3/8.
//  Copyright © 2019 macpro. All rights reserved.
//

// 参考：https://github.com/TimOliver/TOCropViewController.git

#import "HqClipVC.h"

@interface HqClipVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *contentView;
@property (nonatomic,strong) UIImageView *bgImageView;

@end
//
@implementation HqClipVC
- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _contentView.delegate = self;
      
    }
    return _contentView;
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _bgImageView.image = [UIImage imageNamed:@"hq_bg.jpeg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.bgImageView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
    NSLog(@"scale is %f",scale);
    [scrollView setZoomScale:scale animated:NO];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll==");
}

- (void)settingScrollViewZoomScaleWithClipWidth:(CGFloat)ClipWidth {
    CGFloat imageWidth = self.bgImageView.image.size.width;
    CGFloat imageHeight = self.bgImageView.image.size.height;
    CGFloat vw = self.view.bounds.size.width;
    if (imageWidth > imageHeight) {
        self.contentView.minimumZoomScale = ClipWidth / (imageHeight / imageWidth * vw);
    } else {
        self.contentView.minimumZoomScale = ClipWidth / vw;
    }
    self.contentView.maximumZoomScale = (self.contentView.minimumZoomScale) * 5.0;
    self.contentView.zoomScale = self.contentView.minimumZoomScale > 1 ? self.contentView.minimumZoomScale : 1;
    CGFloat top = (self.view.bounds.size.height - ClipWidth)/2.0;
    CGFloat left = (self.view.bounds.size.width - ClipWidth)/2.0;
    CGFloat bottom = top;
    CGFloat right = left;


    _contentView.contentInset = UIEdgeInsetsMake(top, left, bottom, right);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.bgImageView];
    [self settingScrollViewZoomScaleWithClipWidth:200];
    
    UIBezierPath *clipPath = [UIBezierPath bezierPath];
    [clipPath addArcWithCenter:self.view.center radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
    UIBezierPath *showPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [showPath appendPath:clipPath];

    CAShapeLayer *showLayer = [CAShapeLayer layer];
    showLayer.fillRule = kCAFillRuleEvenOdd;
    showLayer.fillColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    showLayer.path = showPath.CGPath;
    [self.view.layer addSublayer:showLayer];
    
    
    UIView *centerVX  = [[UIView alloc] init];
    centerVX.backgroundColor = [UIColor purpleColor];
    centerVX.bounds = CGRectMake(0, 0, 200, 5);
    centerVX.center = self.view.center;
    [self.view addSubview:centerVX];
    
    UIView *centerVY  = [[UIView alloc] init];
    centerVY.backgroundColor = [UIColor purpleColor];
    centerVY.bounds = CGRectMake(0, 0, 5, 200);
    centerVY.center = self.view.center;
    [self.view addSubview:centerVY];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
