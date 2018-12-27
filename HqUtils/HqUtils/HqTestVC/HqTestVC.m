//
//  HqTestVC.m
//  HqUtils
//
//  Created by hqmac on 2018/12/26.
//  Copyright © 2018 macpro. All rights reserved.
//

#import "HqTestVC.h"
#import "HqTest1VC.h"
@implementation HqTestVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"HqTestVC";
    
    UILabel *alertLab = [[UILabel alloc] init];
    alertLab.center = self.view.center;
    alertLab.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    alertLab.textAlignment = NSTextAlignmentCenter;
    alertLab.text = @"点击屏幕进入下一页导航将变化";
    [self.view addSubview:alertLab];
    
    //设置导航颜色
    self.navbarCorlor  =[UIColor orangeColor];
    self.isShowBottomLine = NO;
    self.titelLab.textColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
   
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HqTest1VC *vc = [HqTest1VC new];
    [vc pushWithLastVC:self];
}

@end
