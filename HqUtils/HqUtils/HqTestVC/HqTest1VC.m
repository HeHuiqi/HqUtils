//
//  HqTest1VC.m
//  HqUtils
//
//  Created by hqmac on 2018/12/26.
//  Copyright © 2018 macpro. All rights reserved.
//

#import "HqTest1VC.h"
#import "HqTest2VC.h"
@interface HqTest1VC ()

@end

@implementation HqTest1VC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"HqTest1VC";
    
    UILabel *alertLab = [[UILabel alloc] init];
    alertLab.center = self.view.center;
    alertLab.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    alertLab.textAlignment = NSTextAlignmentCenter;
    alertLab.text = @"点击屏幕进入下一页导航将变化";
    [self.view addSubview:alertLab];
    
    
    self.view.backgroundColor  = [UIColor redColor];
    //导航透明
    self.isAlphaZeroNavBar = YES;
    self.titelLab.textColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    v.backgroundColor = v.tintColor;
    [self.view addSubview:v];
    NSLog(@"v.superview.tintColor== %@",v.superview.tintColor);
    NSLog(@"v.tintColor== %@",v.tintColor);

    
    CGColorSpaceRef crfs  = CGColorSpaceCreateDeviceRGB();
    const CGFloat bgColor[4] = {0.6,0.5,0.76,1};
    CGColorRef cgrf =  CGColorCreate(crfs, bgColor);
    self.view.backgroundColor  = [UIColor colorWithCGColor:cgrf];
    CGColorSpaceRelease(crfs);
    CGColorRelease(cgrf);
    
    /*
    const CGFloat *colors = CGColorGetComponents(v.tintColor.CGColor);
    UITableView *tab = [[UITableView alloc] init];
    NSLog(@"tab-color = %@",tab.tintColor);
    NSLog(@"colors[0]R== %f",colors[0]);
    NSLog(@"colors[1]G== %f",colors[1]*255.0);
    NSLog(@"colors[2]B== %f",colors[2]);
    NSLog(@"colors[3]A== %f",colors[3]);
   */
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HqTest2VC *vc = [HqTest2VC new];
    [vc pushWithLastVC:self];
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
