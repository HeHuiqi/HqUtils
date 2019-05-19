//
//  HqThemeVC.m
//  HqUtils
//
//  Created by hqmac on 2019/3/14.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqThemeVC.h"
#import "HqAppView.h"
#import "HGCategoryView.h"

@interface HqThemeVC ()

@property (nonatomic,strong) HqAppView *appView;

@end

@implementation HqThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    HqAppView *appView = [[HqAppView alloc] init];
    appView.backgroundColor = appView.tintColor;
    [self.view addSubview:appView];
    self.appView = appView;
    
    UINavigationBar *navbar = self.navigationController.navigationBar;
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    NSLog(@"statusBarFrame= %@",NSStringFromCGRect(statusBarFrame));
    NSLog(@"navbar==%@",NSStringFromCGRect(navbar.frame));
    NSLog(@"CGRectGetMaxY(statusBarFrame) = %@",@(CGRectGetMaxY(statusBarFrame)));
    NSLog(@"CGRectGetMaxY(navbar.frame) = %@",@(CGRectGetMaxY(navbar.frame)));
    
    CGFloat y = statusBarFrame.size.height+navbar.bounds.size.height;
    NSLog(@"y = %@",@(y));
    self.appView.frame = CGRectMake(0, y, y, 50);
    
    */
    
    HGCategoryView *segv = [[HGCategoryView alloc] init];
    segv.height = 50;
    segv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    segv.titles = @[@"全部",@"我的"];
    
    [self.view addSubview:segv];
    [segv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(100);
        make.height.mas_equalTo(50);
    }];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIColor *color = [self mostColor:[UIImage imageNamed:@"lc.jpg"]];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.view.backgroundColor = color;
//        });
//    });
    
}

//根据图片获取图片的主色调
- (UIColor*)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.appView.tintColor = [UIColor redColor];
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
