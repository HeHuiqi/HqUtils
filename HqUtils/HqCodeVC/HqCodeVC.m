//
//  HqCodeVC.m
//  HqUtils
//
//  Created by hehuiqi on 6/21/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCodeVC.h"
#import "UIImage+QStion.h"
#import "UIView+HqSetCorner.h"
#import "HqSetCornerView.h"

#import <AssetsLibrary/AssetsLibrary.h>


#import "HqRandomBadgeView.h"


@interface HqCodeVC ()<HqRandomBadgeViewDelegate>


@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) HqRandomBadgeView *randomView;
@property (nonatomic,strong) UILabel *assetLab;



@end

@implementation HqCodeVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //[self testRandomView];
    [self testLayer];
    

}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches
              withEvent:event];
    
    [self randomShowBtn];

}
- (void)testLayer{
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 130, 150)];
    shadowView.backgroundColor = [UIColor whiteColor];
    CALayer *shadowlayer = [CALayer layer];
    CGFloat shadowRadius = 10;
    shadowlayer.shadowColor = [UIColor redColor].CGColor;
    shadowlayer.shadowOffset = CGSizeMake(1.0, 1.0);
    shadowlayer.shadowRadius = shadowRadius;
    shadowlayer.shadowOpacity = 0.5;
    shadowlayer.cornerRadius = shadowRadius;
    shadowlayer.backgroundColor = shadowView.backgroundColor.CGColor;
    CGFloat shadowlayerW = shadowView.bounds.size.width-shadowRadius;
    CGFloat shadowlayerH = shadowView.bounds.size.height-shadowRadius;
    shadowlayer.frame = CGRectMake(shadowRadius, shadowRadius, shadowlayerW, shadowlayerH);
    [shadowView.layer addSublayer:shadowlayer];
    [self.view addSubview:shadowView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 150, 150)];
//    imageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.borderColor = [UIColor purpleColor].CGColor;
    imageView.layer.borderWidth = 1;
    CGFloat w  = shadowView.bounds.size.width+shadowlayer.shadowRadius;
    CGFloat h  = shadowView.bounds.size.height+shadowlayer.shadowRadius;

    NSLog(@"w == %@",@(w));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), NO, 0.0);
    [shadowView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    imageView.image = image;
    BOOL saveImage = YES;
    if (saveImage) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            NSLog(@"error==%@",error);
        }];
    }
}
- (void)testRandomView{
    
    self.randomView = [[HqRandomBadgeView alloc] initWithFrame:CGRectMake(0,200, SCREEN_WIDTH, 240)];
    self.randomView.delegate = self;
    self.randomView.backgroundColor = HqRandomColor;
    [self.view addSubview:self.randomView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.randomView.frame)+10, 60, 60)];
    lab.backgroundColor = [UIColor redColor];
    lab.textColor = [ UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    self.assetLab = lab;
}
- (void)randomShowBtn{
    NSMutableArray *datas = @[].mutableCopy;
    
    for (int i = 0; i<10; i++) {
        HqRandomModel *model = [[HqRandomModel alloc] init];
        model.index = i;
        model.dataValue = @(i).stringValue;
        [datas addObject:model];
    }
    self.randomView.datas = datas;
    
}

#pragma mark - HqRandomBadgeViewDelegate
- (void)randomBadgeView:(HqRandomBadgeView *)view didSelectedModel:(HqRandomModel *)model{
    NSLog(@"点了一个==%@",model.dataValue);
    self.assetLab.text = model.dataValue;

}
- (void)randomBadgeView:(HqRandomBadgeView *)view deleteAllModel:(HqRandomModel *)model{
    NSLog(@"点完了");
    self.assetLab.text = model.dataValue;

    NSMutableArray *datas = @[].mutableCopy;
    
    for (int i = 0; i<10; i++) {
        HqRandomModel *model = [[HqRandomModel alloc] init];
        model.index = i;
        model.dataValue = @(i).stringValue;
        [datas addObject:model];
    }
    view.datas = datas;
}
@end
