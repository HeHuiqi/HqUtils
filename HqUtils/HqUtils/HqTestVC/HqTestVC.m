//
//  HqTestVC.m
//  HqUtils
//
//  Created by hqmac on 2018/12/26.
//  Copyright © 2018 macpro. All rights reserved.
//

#import "HqTestVC.h"
#import "HqTest1VC.h"
#import "HqIconLab.h"
#import "UIView+HqSetCorner.h"
#import "HqCornerTestView.h"
#import "HqTimer.h"
@interface HqTestVC()

@property (nonatomic,strong) HqTimer *timer;

@end
@implementation HqTestVC
- (void)dealloc{
    NSLog(@"HqTestVC-dealloc");
//    [self.timer destroyNStimer];
    [self.timer destroyDispatchTimer];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"HqTestVC";
    
    UILabel *alertLab = [[UILabel alloc] init];
    alertLab.center = self.view.center;
    alertLab.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    alertLab.textAlignment = NSTextAlignmentCenter;
    alertLab.text = @"点击屏幕进入下一页导航将变化";
    [self.view addSubview:alertLab];
    
    //设置导航颜色
    self.navbarCorlor  =[UIColor orangeColor];
    self.isShowBottomLine = NO;
    self.titelLab.textColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
  
    
    HqCornerTestView *v = [[HqCornerTestView alloc] init];
    v.backgroundColor = [UIColor lightGrayColor];
  
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 150));
    }];
    v.layer.borderColor = [UIColor purpleColor].CGColor;
    v.layer.borderWidth = 5;
    [v hqSetCornerRaduis:10];
    
    UIView *v1 = [[UIView alloc] init];
    v1.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:v1];
    [v1 hqSetCorner:HQUIRectCornerTopLeft | HQUIRectCornerTopRight raduis:10];
    v1.layer.borderColor = [UIColor purpleColor].CGColor;
    v1.layer.borderWidth = 5;
    
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v.mas_right).offset(20);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 150));
    }];
    
    
//   self.timer =  [HqTimer hq_dispatchTimerWithTarget:self timeInterval:1 repeats:YES handler:^(dispatch_source_t timer) {
//        NSLog(@"--hq_dispatchTimerWithTarget-");
//    }];
    
//    self.timer = [HqTimer hq_nsTimerWithTimeInterval:1.0 repeats:YES handler:^(HqTimer *hqTimer) {
//        NSLog(@"--hq_nsTimerWithTimeInterval-");
//    }];
   
}
- (CGFloat )getTextWidthWithString:(NSString *)string fontSize:(CGFloat )size textHeight:(CGFloat)height
{
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil].size;
    return contentSize.width;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HqTest1VC *vc = [HqTest1VC new];
    [vc pushWithLastVC:self];
    
}


@end
