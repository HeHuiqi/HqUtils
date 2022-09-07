//
//  HqColorSelectBoardVC.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqColorSelectBoardVC.h"

@interface HqColorSelectBoardVC ()

@property(nonatomic,strong) UIView *showColorView;
@property(nonatomic,strong) UIView *lineWidthView;

@property(nonatomic,strong) UISlider *redSlider;
@property(nonatomic,strong) UISlider *greenSlider;
@property(nonatomic,strong) UISlider *blueSlider;
@property(nonatomic,strong) UISlider *lineSlider;


@end

@implementation HqColorSelectBoardVC

- (UIView *)showColorView{
    if (!_showColorView) {
        _showColorView = [[UIView alloc] init];
        _showColorView.layer.cornerRadius = 8.0;
    }
    return _showColorView;
}
- (UIView *)lineWidthView{
    if (!_lineWidthView) {
        _lineWidthView = [[UIView alloc] init];
        _lineWidthView.backgroundColor = [UIColor blackColor];
        _lineWidthView.layer.cornerRadius = 6.0;

    }
    return _lineWidthView;
}
- (UISlider *)createSlider {
    UISlider *slider = [[UISlider alloc] init];
    slider.minimumValue = 0.0;
    slider.maximumValue = 255.0;
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:(UIControlEventValueChanged)];
    return slider;
}
- (void)sliderChange:(UISlider *)slider{
    if (slider.tag == 4) {
        self.lineWidth = slider.value;
        CGRect bounds = self.lineWidthView.frame;
        bounds.size.width = slider.value;
        self.lineWidthView.frame = bounds;
        return;
    }
 
    [self refreshColor];
    
}
- (void)refreshColor{
    CGFloat red = self.redSlider.value;
    CGFloat green = self.greenSlider.value;
    CGFloat blue = self.blueSlider.value;
    
    UIColor *color = [[UIColor alloc] initWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    self.showColorView.backgroundColor = color;
}

- (UISlider *)redSlider{
    if (!_redSlider) {
        _redSlider = [self createSlider];
        _redSlider.tag = 1;
        _redSlider.value = 39.0;
        _redSlider.tintColor = [UIColor redColor];
    }
    return _redSlider;
}

- (UISlider *)greenSlider{
    if (!_greenSlider) {
        _greenSlider = [self createSlider];
        _greenSlider.value = 90;
        _greenSlider.tag = 2;

        _greenSlider.tintColor = [UIColor greenColor];
    }
    return _greenSlider;
}
- (UISlider *)blueSlider{
    if (!_blueSlider) {
        _blueSlider = [self createSlider];
        _blueSlider.tag = 3;
        _blueSlider.value = 67;
        _blueSlider.tintColor = [UIColor blueColor];
    }
    return _blueSlider;
}
- (UISlider *)lineSlider{
    if (!_lineSlider) {
        _lineSlider = [[UISlider alloc] init];
        _lineSlider.tag = 4;
        _lineSlider.minimumValue = 1;
        _lineSlider.maximumValue = 50.0;
        [_lineSlider addTarget:self action:@selector(sliderChange:) forControlEvents:(UIControlEventValueChanged)];
        _lineSlider.value = self.lineWidth > 0 ? self.lineWidth : 5;

    }
    return _lineSlider;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.showColorView];
    [self.view addSubview:self.lineSlider];
    [self.view addSubview:self.lineWidthView];

    [self.view addSubview:self.redSlider];
    [self.view addSubview:self.greenSlider];
    [self.view addSubview:self.blueSlider];

    if (self.currentColor != nil) {
        CGFloat red = 0.0;
        CGFloat green = 0.0;
        CGFloat blue = 0.0;
        CGFloat alpha = 0.0;
        [self.currentColor getRed:&red green:&green blue:&blue alpha:&alpha];
        if (red > 0) {
            self.redSlider.value = red*255.0;
        }
        if (green > 0) {
            self.greenSlider.value = green*255.0;
        }
        if (blue > 0) {
            self.blueSlider.value = blue*255.0;
        }

    }
    [self refreshColor];

    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(confirmColor)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self sliderChange:self.lineSlider];

}
- (void)confirmColor{
    UIColor *color = self.showColorView.backgroundColor;
    if (color) {
        if ([self.delegate respondsToSelector:@selector(hqColorSelectBoardVC:selectColor:)] && self.delegate) {
            [self.delegate hqColorSelectBoardVC:self selectColor:color];
        }
    }
    Back();

}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat colorViewY = self.navBarHeight + 10;
    CGFloat colorViewX = 20;
    CGFloat colorViewW = self.view.bounds.size.width - colorViewX * 2;
    self.showColorView.frame = CGRectMake(colorViewX, colorViewY, colorViewW, 150);
    self.lineWidthView.frame = CGRectMake(colorViewX+30, colorViewY, self.lineSlider.value, 150);

    self.redSlider.frame = CGRectMake(colorViewX, CGRectGetMaxY(self.showColorView.frame)+5, colorViewW, 30);
    self.greenSlider.frame = CGRectMake(colorViewX, CGRectGetMaxY(self.redSlider.frame)+5, colorViewW, 30);
    self.blueSlider.frame = CGRectMake(colorViewX, CGRectGetMaxY(self.greenSlider.frame)+5, colorViewW, 30);
    self.lineSlider.frame = CGRectMake(colorViewX, CGRectGetMaxY(self.blueSlider.frame)+5, colorViewW, 30);
}

@end
