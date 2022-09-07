//
//  HqPainterVC.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/30.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqPainterVC.h"
#import "HqPainterView.h"
#import "HqColorSelectBoardVC.h"
#import "HqProPainterView.h"
#import "HqLocalPaintVC.h"

@interface HqPainterVC ()<HqColorSelectBoardVCDelegate,HqLocalPaintVCDelegate>

@property(nonatomic,strong)HqPainterView *painterView;
@property(nonatomic,strong)HqProPainterView *proPainterView;

@property(nonatomic,strong)HqPainterToolBar *toolBar;

@end

@implementation HqPainterVC

- (HqPainterView *)painterView{
    if (!_painterView) {
        _painterView = [[HqPainterView alloc] init];
        _painterView.accrossLayerDraw = NO;
        _painterView.backgroundColor = [UIColor lightGrayColor];
        _painterView.toolBarView = self.toolBar;

    }
    return _painterView;
}
- (HqProPainterView *)proPainterView{
    if (!_proPainterView) {
        _proPainterView = [[HqProPainterView alloc] init];
        _proPainterView.backgroundColor = [UIColor lightGrayColor];
        _proPainterView.toolBar = self.toolBar;
    }
    return _proPainterView;
}
- (HqPainterToolBar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[HqPainterToolBar alloc] init];
        _toolBar.backgroundColor = [UIColor whiteColor];
    }
    return _toolBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *painterView = self.painterView;
    painterView = self.proPainterView;
    [self.view addSubview:painterView];
    [self.view addSubview:self.toolBar];
    [self.toolBar hqAddTarget:self action:@selector(btnClick:)];

}
- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 3) {
        HqColorSelectBoardVC *colorSelectedVC = [[HqColorSelectBoardVC alloc] init];
        colorSelectedVC.lineWidth = self.painterView.lineWidth;
        colorSelectedVC.currentColor = self.painterView.strokeColor;
        colorSelectedVC.delegate = self;
        Push(colorSelectedVC);
        return;
    }
    if (btn.tag == 4) {
        [self.proPainterView saveToFile];
        
        return;
    }
    if (btn.tag == 5) {

        
        HqLocalPaintVC *vc = [[HqLocalPaintVC alloc] init];
        vc.delegate = self;
        Push(vc);
        
        return;
    }
    
    [self.proPainterView drawOptType:btn.tag];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat toolBarH = 44;
    CGFloat painterViewH = self.view.bounds.size.height - self.navBarHeight - toolBarH;
    UIView *painterView = self.painterView;
    painterView = self.proPainterView;
    painterView.frame = CGRectMake(0, self.navBarHeight, self.view.bounds.size.width, painterViewH);
    self.toolBar.frame = CGRectMake(0, CGRectGetMaxY(painterView.frame), self.view.bounds.size.width, toolBarH);
}
#pragma mark - HqColorSelectBoardVCDelegate
- (void)hqColorSelectBoardVC:(HqColorSelectBoardVC *)vc selectColor:(UIColor *)color{
    if (color) {
        self.proPainterView.strokeColor = color;
    }
    if (vc.lineWidth > 0) {
        self.proPainterView.lineWidth = vc.lineWidth;
    }
}
- (void)hqLocalPaintVC:(HqLocalPaintVC *)vc paintLayer:(CAShapeLayer *)paintLayer{
    [self.proPainterView loadLayers:paintLayer.sublayers];
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
