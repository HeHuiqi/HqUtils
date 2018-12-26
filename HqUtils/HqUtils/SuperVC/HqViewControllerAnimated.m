//
//  HqViewControllerAnimated.m
//  HqX
//
//  Created by macpro on 2018/3/21.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqViewControllerAnimated.h"

@implementation HqViewControllerAnimated

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalRect, [UIScreen mainScreen].bounds.size.width, 0);
    [[transitionContext containerView] addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        toVC.view.frame = finalRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

@end
