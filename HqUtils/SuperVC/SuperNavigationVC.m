//
//  SuperNavigationVC.m
//  HHQ
//
//  Created by iMac on 15/7/17.
//  Copyright (c) 2015年 HHQ. All rights reserved.
//

//#define NavigationBarColor COLOR(59, 181, 247, 1)

#import "SuperNavigationVC.h"
#import "HqViewControllerAnimated.h"

@interface SuperNavigationVC ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation SuperNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;

//    self.delegate = self;
    /*
    if ( @available(iOS 11.0, *)) {
        self.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    }
    */
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    BOOL isPop = self.viewControllers.count==1 ? NO:YES;
    return isPop;
}

//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    return [[HqViewControllerAnimated alloc] init];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
