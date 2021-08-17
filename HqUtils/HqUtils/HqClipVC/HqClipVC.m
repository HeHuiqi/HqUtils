//
//  HqClipVC.m
//  HqUtils
//
//  Created by hqmac on 2019/3/8.
//  Copyright © 2019 macpro. All rights reserved.
//

// 参考：https://github.com/TimOliver/TOCropViewController.git

#import "HqClipVC.h"
#import "HqArrowImage.h"
#import "HqCloseImage.h"

@interface HqClipVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *contentView;
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIImageView *showImageView;

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
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImageView.image = [UIImage imageNamed:@"lc.jpg"];
//        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}
- (UIImageView *)showImageView{
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.navBarHeight, 100, 100)];
        _showImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _showImageView;
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.bgImageView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
    NSLog(@"scale is %f",scale);
    [scrollView setZoomScale:scale animated:NO];
//    CGFloat ClipWidth = 200;
//    CGFloat initLeft = (self.contentView.bounds.size.width - ClipWidth);
//    CGFloat initTop = (self.contentView.bounds.size.height - ClipWidth);
//    CGFloat imageWidth = self.bgImageView.image.size.width;
//    CGFloat imageHeight = self.bgImageView.image.size.height;
//
//    CGFloat top = initTop/2.0;
////    CGFloat left = (initLeft + scale *initLeft)/2.0 - scale*9.0;
//    CGFloat left = top *scale;
//    CGFloat bottom = top;
//    CGFloat right = left;
//
//    NSLog(@"_contentView.contentSize=%@",@(_contentView.contentSize));
//
//    if (scale > 1.0) {
//        _contentView.contentInset = UIEdgeInsetsMake(top-64, left, bottom, right);
//    }else{
//        _contentView.contentInset = UIEdgeInsetsMake(top, left, bottom, right);
//    }
//
//    NSLog(@"_contentView.contentInset==%@",@(_contentView.contentInset));

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidScroll==");
}

- (void)settingScrollViewZoomScaleWithClipWidth:(CGFloat)ClipWidth {
    CGFloat imageWidth = self.bgImageView.image.size.width;
    CGFloat imageHeight = self.bgImageView.image.size.height;
    self.contentView.minimumZoomScale = 0.5;
    self.contentView.maximumZoomScale = (self.contentView.minimumZoomScale) * 5.0;
    self.contentView.zoomScale = self.contentView.minimumZoomScale > 1 ? self.contentView.minimumZoomScale : 1;
    NSLog(@"self.contentView.zoomScale=%@",@(self.contentView.zoomScale));

    CGFloat initLeft = (self.contentView.bounds.size.width - ClipWidth);
    CGFloat initTop = (self.contentView.bounds.size.height - ClipWidth);
    
    CGFloat top = initTop/2.0;
    CGFloat left = initLeft/2.0;


    CGFloat bottom = top;
    CGFloat right = left;

    NSLog(@"_contentView.contentSize=%@",@(_contentView.contentSize));

    _contentView.contentInset = UIEdgeInsetsMake(top, left, bottom, right);
    NSLog(@"_contentView.contentInset==%@",@(_contentView.contentInset));
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    [self.view addSubview:self.contentView];
//    self.contentView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.bgImageView];
    [self settingScrollViewZoomScaleWithClipWidth:200];
    
//    [self.view addSubview:self.bgImageView];
    UIBezierPath *clipPath = [UIBezierPath bezierPath];
//    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x-100, self.view.center.y-100, 200, 200)];
    [clipPath addArcWithCenter:self.view.center radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
  

    UIBezierPath *showPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [showPath appendPath:clipPath];

    CAShapeLayer *showLayer = [CAShapeLayer layer];
    showLayer.fillRule = kCAFillRuleEvenOdd;
    showLayer.fillColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    showLayer.path = showPath.CGPath;
    [self.view.layer addSublayer:showLayer];
    */
    
    [self.view addSubview:self.showImageView];


    HqArrowImage *arromImage = [[HqArrowImage alloc] init];
    arromImage.arrowColor = [UIColor systemRedColor];
    
    UIImage *image = arromImage.makeImage;
    image = HqArrowImage.navBackImage;
//    image = HqArrowImage.tableArrowImage;
    image = HqArrowImage.questionImage;
    
    HqCloseImage *closeImage = [[HqCloseImage alloc] init];
    closeImage.imageSize = CGSizeMake(50, 50);
//    closeImage.closeStyle = HqCloseImageStyleHaveCircleBorder;
    image = [closeImage makeImage];
    self.showImageView.image = image;
    
    
    
    CGRect bounds = self.showImageView.bounds;
    bounds.size = image.size;
    self.showImageView.bounds = bounds;
    
    
//    UIView *centerVX  = [[UIView alloc] init];
//    centerVX.backgroundColor = [UIColor purpleColor];
//    centerVX.bounds = CGRectMake(0, 0, 200, 5);
//    centerVX.center = self.view.center;
//    [self.view addSubview:centerVX];
//
//    UIView *centerVY  = [[UIView alloc] init];
//    centerVY.backgroundColor = [UIColor purpleColor];
//    centerVY.bounds = CGRectMake(0, 0, 5, 200);
//    centerVY.center = self.view.center;
//    [self.view addSubview:centerVY];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(clipImage)];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemSave) target:self action:@selector(saveImage)];

    
    self.navigationItem.rightBarButtonItems = @[saveItem,rightItem];
    
    

    
    
}
- (void)saveImage{
    UIImage *image = self.showImageView.image;
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [Dialog simpleToast:@"保存成功"];
    }

}
- (void)clipImage{
    CGRect captureRect = CGRectMake(self.view.center.x-100, self.view.center.y-100, 200, 200);
    [self captureRectImageWithView:self.view captureRect:captureRect];
}
- (void)captureRectImageWithView:(UIView *)view captureRect:(CGRect)captureRect{
    CGSize viewSize = view.bounds.size;
    
    //截取view
    UIGraphicsBeginImageContextWithOptions(viewSize, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"image==%@",image);
    
    //截取图片所需区域
    CGImageRef sourceImageRef = [image CGImage];
    NSLog(@"captureRect==%@",@(captureRect));
    CGFloat scale = image.scale;
    CGRect targetRect = CGRectMake(captureRect.origin.x*scale, captureRect.origin.y*scale, captureRect.size.width*scale, captureRect.size.height*scale);

    //CGImageRef
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, targetRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    NSLog(@"newImage==%@",newImage);
    
    newImage = [self imageWithSourceImage:newImage];
    newImage = [self imageToTransparent:newImage];
    

    UIImage *doneImage = nil;
    
    UIGraphicsBeginImageContextWithOptions((CGSize){17,14}, NO, 0.0f);
    {


        /*
         //第一种绘制
         CGContextRef context = UIGraphicsGetCurrentContext();
         CGContextSetLineWidth(context, 2);
         CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGMutablePathRef path = CGPathCreateMutable();;
        CGAffineTransform transform = CGAffineTransformIdentity;
        CGPathMoveToPoint(path, &transform, 1, 7);
        CGPathAddLineToPoint(path, &transform, 6, 12);
        CGPathAddLineToPoint(path, &transform, 16, 1);
        CGContextAddPath(context, path);
        CGContextStrokePath(context);
        CGPathRelease(path);
        */
        
        /*
         //第二种
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 2);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextMoveToPoint(context, 1, 7);
        CGContextAddLineToPoint(context, 6, 12);
        CGContextAddLineToPoint(context, 16, 1);
        CGContextStrokePath(context);
        */
        //第三种
        UIBezierPath* rectanglePath = UIBezierPath.bezierPath;
        [rectanglePath moveToPoint: CGPointMake(1, 7)];
        [rectanglePath addLineToPoint: CGPointMake(6, 12)];
        [rectanglePath addLineToPoint: CGPointMake(16, 1)];
        [UIColor.redColor setStroke];
        rectanglePath.lineWidth = 2;
        [rectanglePath stroke];
        
        
        
        doneImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    
    
    UIImage *showImage = doneImage;
    

    self.showImageView.image = showImage;
    CGRect bounds = self.showImageView.bounds;
    bounds.size = showImage.size;
    self.showImageView.bounds = bounds;
    
    
}

- (UIImage *)imageWithSourceImage:(UIImage *)sourceImage {
//    UIGraphicsBeginImageContext(sourceImage.size);
    UIGraphicsBeginImageContextWithOptions(sourceImage.size, NO, sourceImage.scale);

    //bezierPathWithOvalInRect方法后面传的Rect,可以看作(x,y,width,height),前两个参数是裁剪的中心点,后面两个决定裁剪的区域是圆形还是椭圆.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height)];
    //把路径设置为裁剪区域(超出裁剪区域以外的内容会自动裁剪掉)
//    [[UIColor clearColor] setFill];
    [path addClip];
    //把图片绘制到上下文当中
    [sourceImage drawAtPoint:CGPointZero];
    //从上下文当中生成一张新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    //返回新的图片
    return newImage;
}
//去除图片的白色背景

- (UIImage*) imageToTransparent:(UIImage*) image

{

    // 分配内存

    const int imageWidth = image.size.width;

    const int imageHeight = image.size.height;

    size_t bytesPerRow = imageWidth * 4;

    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);

    

    // 创建context

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,

                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);

    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);

    

    // 遍历像素

    int pixelNum = imageWidth * imageHeight;

    uint32_t* pCurPtr = rgbImageBuf;

    for (int i = 0; i < pixelNum; i++, pCurPtr++)

    {

//        //去除白色...将0xFFFFFF00换成其它颜色也可以替换其他颜色。

//        if ((*pCurPtr & 0xFFFFFF00) >= 0xffffff00) {

//

//            uint8_t* ptr = (uint8_t*)pCurPtr;

//            ptr[0] = 0;

//        }

        //接近白色

        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B

        //分别取出RGB值后。进行判断需不需要设成透明。

        uint8_t* ptr = (uint8_t*)pCurPtr;

        if (ptr[1] > 240 && ptr[2] > 240 && ptr[3] > 240) {

            //当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净

            ptr[0] = 0;

        }

    }

     // 将内存转成image

    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);

    

    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,

                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,

                                        NULL, true,kCGRenderingIntentDefault);

    CGDataProviderRelease(dataProvider);

    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];

    // 释放

    CGImageRelease(imageRef);

    CGContextRelease(context);

    CGColorSpaceRelease(colorSpace);

    return resultUIImage;

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
