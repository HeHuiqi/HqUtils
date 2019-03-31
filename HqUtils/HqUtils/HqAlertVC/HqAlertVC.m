//
//  HqAlertVC.m
//  HqUtils
//
//  Created by hqmac on 2019/1/18.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqAlertVC.h"

@interface HqAlertVC ()


@property (nonatomic,strong) UIView *bgcontentView;

@end

@implementation HqAlertVC
- (void)dealloc{
    NSLog(@"HqAlertVC--dealloc");
}
- (instancetype)init{
    if (self = [super init]) {
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.contentHeight = HqHZoomValue(300);
    }
    return self;
}
- (void)showWithVC:(UIViewController *)vc{
    [vc presentViewController:self animated:NO completion:nil];
    [self hqLayoutSubViews];
}
- (void)hqLayoutSubViews{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIColor *color = [UIColor blackColor];
    color = [color colorWithAlphaComponent:0.5];
    self.view.backgroundColor = color;
    [self.view addSubview:self.contentView];
    CGFloat h = self.contentHeight;
    CGFloat w = self.view.bounds.size.width;
    self.view.alpha = 0;
    _contentView.frame = CGRectMake(0, self.view.bounds.size.height, w, h);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            self.view.alpha = 1.0;
            self.contentView.frame = CGRectMake(0, self.view.bounds.size.height-h, w, h);
        }];
    });
    
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
        UIView *view = obj.view;
        if ([view isEqual:self.view]) {
            [UIView animateWithDuration:0.2 animations:^{
                self.contentView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.contentHeight);
            } completion:^(BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
            }];
        }
    }];
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
