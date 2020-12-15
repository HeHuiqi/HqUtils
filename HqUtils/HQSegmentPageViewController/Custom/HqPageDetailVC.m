//
//  HqPageDetailVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/18/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPageDetailVC.h"

@interface HqPageDetailVC ()

@end

@implementation HqPageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HqPageDetailVC";
    [self preVCVC];
}
- (id)preVCVC{
    UIWindow *currentWindow = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootVC = currentWindow.rootViewController;
    
    UIViewController * _Nullable (^HqNavTopVC)(UIViewController *) = ^(UIViewController *vc) {
        UIViewController *topVC = nil;
        if ([vc isKindOfClass:UINavigationController.class]) {
            NSArray *vcs = vc.childViewControllers;
            if (vcs.count>0) {
                NSInteger preIndex = (vcs.count-2);
                preIndex = preIndex<=0 ? 0:preIndex;
               UIViewController *topVC  = vcs[preIndex];
                NSLog(@"vc==%@,title=%@",topVC.class,topVC.title);
            }
        }
        return topVC;
    };
    
    if (rootVC) {
        if ([rootVC isKindOfClass:UITabBarController.class]) {
            UITabBarController *tabVC = (UITabBarController *)rootVC;
            UIViewController *selectedVC = tabVC.selectedViewController;
            return HqNavTopVC(selectedVC);
        }
        if ([rootVC isKindOfClass:UINavigationController.class]) {
            return HqNavTopVC(rootVC);
        }
    }
    return nil;

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
