//
//  HqPainterToolBar.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqPainterToolBar.h"

@implementation HqPainterToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIButton *)createBtnWithTitle:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [btn setTitle:title forState:(UIControlStateNormal)];
    return btn;
}
- (UIButton *)undoBtn{
    if (!_undoBtn) {
        _undoBtn = [self createBtnWithTitle:@"撤销"];
        _undoBtn.tag = 1;
        _undoBtn.enabled = NO;
    }
    return _undoBtn;
}
- (UIButton *)redoBtn{
    if (!_redoBtn) {
        _redoBtn = [self createBtnWithTitle:@"恢复"];
        _redoBtn.tag = 2;
        _redoBtn.enabled = NO;
    }
    return _redoBtn;
}
- (UIButton *)setBtn{
    if (!_setBtn) {
        _setBtn = [self createBtnWithTitle:@"颜色"];
        _setBtn.tag = 3;
    }
    return _setBtn;
}

- (UIButton *)openBtn{
    if (!_openBtn) {
        _openBtn = [self createBtnWithTitle:@"打开"];
        _openBtn.tag = 5;
    }
    return _openBtn;
}
- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [self createBtnWithTitle:@"保存"];
        _saveBtn.tag = 4;
    }
    return _saveBtn;
}
- (void)setup{
    [self addSubview:self.undoBtn];
    [self addSubview:self.redoBtn];
    [self addSubview:self.setBtn];
    [self addSubview:self.saveBtn];
    [self addSubview:self.openBtn];


    [self hqLayoutSuviews];
}
- (void)hqAddTarget:(id)target action:(SEL)action{
    [self.undoBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self.redoBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self.setBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self.openBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self.saveBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

}
- (void)hqLayoutSuviews{
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnW = 60;
    CGFloat btnH = 44;
    self.redoBtn.frame = CGRectMake(self.bounds.size.width-btnW, self.bounds.size.height-btnH, btnW, btnH);
    self.undoBtn.frame = CGRectMake(CGRectGetMinX(self.redoBtn.frame)-btnW, self.bounds.size.height-btnH, btnW, btnH);
    self.setBtn.frame = CGRectMake(CGRectGetMinX(self.undoBtn.frame)-btnW, self.bounds.size.height-btnH, btnW, btnH);
    
    self.openBtn.frame = CGRectMake(0, self.bounds.size.height-btnH, btnW, btnH);
    self.saveBtn.frame = CGRectMake(CGRectGetMaxX(self.openBtn.frame), self.bounds.size.height-btnH, btnW, btnH);
    
}
@end
