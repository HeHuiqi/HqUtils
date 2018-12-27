//
//  HqTest2VC.m
//  HqUtils
//
//  Created by hqmac on 2018/12/26.
//  Copyright © 2018 macpro. All rights reserved.
//

#import "HqTest2VC.h"

@interface HqTest2VC ()

@end

@implementation HqTest2VC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"HqTest2VC";
    self.view.backgroundColor = [UIColor whiteColor];
    //改变底线颜色
    self.bottomLineColor = [UIColor redColor];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

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
