//
//  HqCoreTextVC.m
//  HqUtils
//
//  Created by hehuiqi on 8/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCoreTextVC.h"
#import "HqCoreTextView.h"

@interface HqCoreTextVC ()

@property (nonatomic,strong) HqCoreTextView *drawView;
@property (nonatomic,strong) HqCoreTextView *drawLineView;
@property (nonatomic,strong) UILabel *showLab;



@end

@implementation HqCoreTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.drawView];
    [self.view addSubview:self.drawLineView];

    
}
- (UILabel *)showLab{
    if (!_showLab) {
        _showLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40, 100)];
        _showLab.backgroundColor = HqRandomColor;
        _showLab.numberOfLines = 0;
    }
    return _showLab;
}
- (HqCoreTextView *)drawLineView{
    if (!_drawLineView) {
        CGFloat y = CGRectGetMaxY(self.drawView.frame)+20;
        y = 100;
        _drawLineView = [[HqCoreTextView alloc] initWithFrame:CGRectMake(20, y, 300, 300)];
        _drawLineView.drawWay = 0;
        _drawLineView.backgroundColor = HqRandomColor;
    }
    return _drawLineView;
}

- (HqCoreTextView *)drawView{
    if (!_drawView) {
        _drawView = [[HqCoreTextView alloc] initWithFrame:CGRectMake(20, 100, 300, 300)];
        _drawView.drawWay = 1;
        _drawView.backgroundColor = HqRandomColor;
    }
    return _drawView;
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
