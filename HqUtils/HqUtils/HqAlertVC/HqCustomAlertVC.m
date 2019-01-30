//
//  HqCustomAlertVC.m
//  HqUtils
//
//  Created by hqmac on 2019/1/29.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqCustomAlertVC.h"

@interface HqCustomAlertVC ()

@end

@implementation HqCustomAlertVC
- (void)dealloc{
    NSLog(@"HqCustomAlertVC--dealloc");
}
- (instancetype)init{
    if (self = [super init]) {
         self.contentHeight = 100;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}
- (void)hqLayoutSubViews{
    [super hqLayoutSubViews];
   self.subLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 30)];
    self.subLab.text = @"SubView";
    [self.contentView addSubview:self.subLab];
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
