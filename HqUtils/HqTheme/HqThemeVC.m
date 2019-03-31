//
//  HqThemeVC.m
//  HqUtils
//
//  Created by hqmac on 2019/3/14.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqThemeVC.h"
#import "HqAppView.h"

@interface HqThemeVC ()

@property (nonatomic,strong) HqAppView *appView;

@end

@implementation HqThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
