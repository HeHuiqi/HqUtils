//
//  HqKeyboardUseVC.m
//  HqUtils
//
//  Created by hehuiqi on 2018/4/9.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqKeyboardUseVC.h"
#import "HqKeyBoard.h"
@interface HqKeyboardUseVC ()

@property (nonatomic,strong) UITextField *tf;

@end

@implementation HqKeyboardUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tf];
    HqKeyBoard *keyborad = [[HqKeyBoard alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 220)];
    keyborad.tf = self.tf;
    self.tf.inputView = keyborad;
    
}
- (UITextField *)tf{
    if (!_tf) {
        _tf = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 100, 40)];
        _tf.borderStyle = UITextBorderStyleRoundedRect;
        _tf.placeholder = @"请输入";
    }
    return _tf;
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
