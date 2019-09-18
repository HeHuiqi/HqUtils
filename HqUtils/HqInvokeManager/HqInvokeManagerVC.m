//
//  HqInvokeManagerVC.m
//  HqTestdYSM
//
//  Created by hehuiqi on 6/12/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import "HqInvokeManagerVC.h"

#import "HqInvokeManager.h"

@interface HqInvokeManagerVC ()

@property (nonatomic,strong) HqInvokeManager *invokeM;

@property (nonatomic,strong) UITextView *logV;


@end

@implementation HqInvokeManagerVC
- (UITextView *)logV{
    if (!_logV) {
        CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height+64;
        CGFloat x = 40;
        
        _logV = [[UITextView alloc] initWithFrame:CGRectMake(x, y, self.view.bounds.size.width-x*2, self.view.bounds.size.height-y)];
        _logV.font = SetFont(20);
        _logV.editable = NO;
    }
    return _logV;
}
- (HqInvokeManager *)invokeM{
    if (!_invokeM) {
        _invokeM = [[HqInvokeManager alloc] init];
    }
    return _invokeM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.logV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"开始调用" forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, 100, 80);
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnClick:(UIButton *)btn{
    //    [self.invokeM invokeInstance:self asyncMethod:@selector(test1)];
    //    [self.invokeM invokeInstance:self asyncMethod:@selector(test2)];
    //    [self.invokeM invokeInstance:self asyncMethod:@selector(test3)];
    //    [self.invokeM start];
    
    NSArray *methods = @[NSStringFromSelector(@selector(test1)),
                         NSStringFromSelector(@selector(test2)),
                         NSStringFromSelector(@selector(test3)),
                         ];
    [self.invokeM invokeInstance:self asyncMethods:methods];
}
- (void)test1{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(3);
        NSLog(@"vc-test1-did");
        [self.invokeM stop];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.logV.text = @"vc-test1-did\n";
        });
        
    });
}
- (void)test2{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(1);
        NSLog(@"vc-test2-did");
        [self.invokeM stop];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *text = self.logV.text;

            self.logV.text = [NSString stringWithFormat:@"%@vc-test2-did\n",text];
        });
        
        
    });
}
- (void)test3{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(2);
        NSLog(@"vc-test3-did");
        [self.invokeM stop];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *text = self.logV.text;

            self.logV.text = [NSString stringWithFormat:@"%@vc-test3-did\n",text];
        });
    });
}


@end
