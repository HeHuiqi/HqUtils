//
//  HqUIResponderVC.m
//  HqUtils
//
//  Created by hqmac on 2019/3/14.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqUIResponderVC.h"
#import "HqCellView.h"

@interface HqUIResponderVC ()

@end

@implementation HqUIResponderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    HqCellView *cell = [[HqCellView alloc] init];
    cell.backgroundColor = cell.tintColor;
    [self.view addSubview:cell];
    UINavigationBar *navbar = self.navigationController.navigationBar;
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    NSLog(@"statusBarFrame= %@",NSStringFromCGRect(statusBarFrame));
    NSLog(@"navbar==%@",NSStringFromCGRect(navbar.frame));
     NSLog(@"CGRectGetMaxY(statusBarFrame) = %@",@(CGRectGetMaxY(statusBarFrame)));
    NSLog(@"CGRectGetMaxY(navbar.frame) = %@",@(CGRectGetMaxY(navbar.frame)));
    cell.tintColor = [UIColor redColor];

    CGFloat y = statusBarFrame.size.height+navbar.bounds.size.height;
    NSLog(@"y = %@",@(y));
    cell.frame = CGRectMake(0, y, y, 50);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"HqUIResponderVC---touchesEnded==%@",touches);
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
