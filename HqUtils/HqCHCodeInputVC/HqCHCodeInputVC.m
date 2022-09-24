//
//  HqCHCodeInputVC.m
//  HqUtils
//
//  Created by hehuiqi on 2022/9/22.
//  Copyright © 2022 hhq. All rights reserved.
//

#import "HqCHCodeInputVC.h"
#import "CHCodeInputView.h"
@interface HqCHCodeInputVC ()
@property(nonatomic,strong) CHCodeInputView *inputView;

@end

@implementation HqCHCodeInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat height = 60;
//    height = 32;
    CGRect rect = CGRectMake(20, self.navBarHeight+40, self.view.bounds.size.width - 40, height);
    self.inputView = [[CHCodeInputView alloc] initWithFrame:rect];
//    self.inputView.style = CHCodeInputViewStylePassword;
    self.inputView.style = CHCodeInputViewStyleText;

    self.inputView.codeCount = 6;
    self.inputView.codeSpace = 20;
//    self.inputView.textChangeColor = @"red";
    
    self.inputView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.inputView];
    
    [self.inputView changeTextState:^{
        NSLog(@"输入验证码：%@",self->_inputView.codeText);
        if (self.inputView.codeText.length == 0) {
            self.inputView.state = CHCodeStateNormal;
        }else{
            self.inputView.state = CHCodeStateError;
        }
        
     
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"--准备输入--");
        [self.inputView becomeFirstResponder];
    });
    
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
