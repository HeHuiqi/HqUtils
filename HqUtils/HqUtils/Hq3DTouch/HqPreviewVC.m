//
//  HqPreviewVC.m
//  RuntimeUse
//
//  Created by macpro on 2017/12/29.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "HqPreviewVC.h"

@interface HqPreviewVC ()<UIPreviewActionItem>

@end

@implementation HqPreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc
                                 ] initWithTarget:self action:@selector(tap)] ;
    [self.view addGestureRecognizer:tap];
    
}
- (void)tap{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//在iOS9.0及以上可用

#pragma mark - UIPreviewActionItem
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *action1 =[UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了分享");
    }];
    
    UIPreviewAction *action2 =[UIPreviewAction actionWithTitle:@"收藏" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了收藏");
    }];
    
    NSArray *actions = @[action1,action2];
    return actions;
}

- (void)didReceiveMemoryWarning {
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
