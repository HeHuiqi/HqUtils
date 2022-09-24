//
//  HqNightModeVC.m
//  HqUtils
//
//  Created by hehuiqi on 2022/9/24.
//  Copyright © 2022 hhq. All rights reserved.
//

#import "HqNightModeVC.h"
#import "HqNightModeView.h"
#import "HqNightModeLayer.h"


@interface HqNightModeVC ()

@end

@implementation HqNightModeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UISwitch *choose = [[UISwitch alloc] init];
    choose.on = [HqNightModeLayer isOpenNightMode];
    
    [self.view addSubview:choose];
    [choose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    [choose addTarget:self action:@selector(turnOnNightMode:) forControlEvents:(UIControlEventValueChanged)];
    
 
    
}
- (void)turnOnNightMode:(UISwitch *)uiswitch{
    NSLog(@"uiswitch.on==%@",@(uiswitch.on));
//    [HqNightModeView openNightMode:uiswitch.on];
    //layer更轻量
    [HqNightModeLayer openNightMode:uiswitch.on];
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
