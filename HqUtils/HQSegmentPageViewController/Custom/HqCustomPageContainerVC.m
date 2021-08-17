//
//  HqCustomPageContainerVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCustomPageContainerVC.h"

@interface HqCustomPageContainerVC ()

@end

@implementation HqCustomPageContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageItems = @[self.pageV1,self.pageV2,self.pageV3];
    [self hqAddChildVCWithindex:self.currentPageIndex];
}

- (HQPage1VC *)pageV1{
    if (!_pageV1) {
        _pageV1 = [[HQPage1VC alloc] init];
        _pageV1.title = @"HQPage1VC";
        
    }
    return _pageV1;
}

- (HQPage1VC *)pageV2{
    if (!_pageV2) {
        _pageV2 = [[HQPage1VC alloc] init];
        _pageV2.title = @"HQPage2VC";
    }
    return _pageV2;
}
- (HQPage1VC *)pageV3{
    if (!_pageV3) {
        _pageV3 = [[HQPage1VC alloc] init];
        _pageV3.title = @"HQPage3VC";        
    }
    return _pageV3;
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
