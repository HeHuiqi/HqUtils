//
//  HqPasswordVC.m
//  HqUtils
//
//  Created by hehuiqi on 2022/9/7.
//  Copyright © 2022 hhq. All rights reserved.
//

#import "HqPasswordVC.h"
#import "HqPassWordView.h"

@interface HqPasswordVC ()<HqPassWordViewDelegate>

@property(nonatomic,strong) HqPassWordView *pswdView;

@end



@implementation HqPasswordVC

- (HqPassWordView *)pswdView{
    if (!_pswdView) {
        _pswdView = [[HqPassWordView alloc] init];
        _pswdView.passWordNum = 6;
        _pswdView.squareWidth = 50;
        _pswdView.pointRadius = 12;
//        _pswdView.isNeedBorder = NO;
        _pswdView.pointColor = [UIColor purpleColor];
        _pswdView.backgroundColor = [UIColor orangeColor];
//        _pswdView.style = HqPassWordViewStyleImage;
        _pswdView.delegate = self;
        
        
    }
    return _pswdView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pswdView];
    [self.pswdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(self.navBarHeight+40);
        CGFloat heigth = self.pswdView.squareWidth;
        CGFloat width = heigth * self.pswdView.passWordNum;
        //注意这里size的设置
        make.size.mas_equalTo(CGSizeMake(width, heigth));
    }];
   
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"--准备输入--");
        [self.pswdView becomeFirstResponder];
    });
}
#pragma mark - HqPassWordViewDelegate
- (void)passWordBeginInput:(HqPassWordView *)passWord{
    NSLog(@"passWordBeginInput");
}
- (void)passWordDidChange:(HqPassWordView *)passWord{
    NSLog(@"passWordDidChange:%@",passWord.textStore);
}
- (void)passWordCompleteInput:(HqPassWordView *)passWord{
    NSLog(@"passWordCompleteInput:%@",passWord.textStore);
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
