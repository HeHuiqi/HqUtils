//
//  ThreeDTouchVC.m
//  RuntimeUse
//
//  Created by macpro on 2017/12/29.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "ThreeDTouchVC.h"
#import "HqPreviewVC.h"

@interface ThreeDTouchVC ()<UIViewControllerPreviewingDelegate>


@property (nonatomic,strong) HqPreviewVC *previewVC;
@end

@implementation ThreeDTouchVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UILabel *lab = [[UILabel alloc] init];
    lab.bounds = CGRectMake(0, 0, 200, 20);
    lab.text = @"3DTouch-长按屏幕";
    lab.center = self.view.center;
    [self.view addSubview:lab];
    _previewVC = [[HqPreviewVC alloc] init];
    //在iOS9.0及以上可用
    [self check3DTouch];

}
//检测页面是否处于3DTouch
- (void)check3DTouch{
    
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            
            [self registerForPreviewingWithDelegate:self sourceView:self.view];
            NSLog(@"3D Touch 开启");
        }
    }
}


#pragma mark - UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    NSLog(@"viewControllerForLocation");
    

    return _previewVC;
}
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    NSLog(@"commitViewController===");
    ///在预览UIViewController界面继续按压进入预览UIViewController
    [self showViewController:viewControllerToCommit sender:self];

}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
