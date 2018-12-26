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
