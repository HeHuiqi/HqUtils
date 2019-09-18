//
//  HSegmentTestVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/27/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HSegmentTestVC.h"
#import "HHSegmentView.h"

@interface HSegmentTestVC ()<HHSegmentViewDelegate>

@property (nonatomic,strong) HHSegmentView *sgv;


@end

@implementation HSegmentTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect barRect = [UIApplication sharedApplication].statusBarFrame;
    CGFloat y = CGRectGetHeight(barRect)+44;
    HHSegmentView *sgv = [[HHSegmentView alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, 50)];
    sgv.itemWidth = 100;
    sgv.delegate = self;
    sgv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:sgv];
    NSMutableArray *titles = @[].mutableCopy;
    for (int i = 0; i<20; i++) {
        NSString *t = [NSString stringWithFormat:@"Test%@",@(i)];
        [titles addObject:t];
    }
    sgv.titles = titles;
    self.sgv = sgv;
//    self.sgv.hideInticator = YES;
//    sgv.hideBtoomLine = YES;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sgv.frame)+150, self.view.bounds.size.width, 40)];
    lab.text = @"点击屏幕改变选择";
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
}
- (void)hhSegmentView:(HHSegmentView *)segmentView selectedIndex:(NSInteger)index{
    NSLog(@"index == %@",@(index));
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.sgv changeIndex:2];
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
