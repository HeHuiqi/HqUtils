//
//  HqTextFiled.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/21.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqTextFiled.h"

@implementation HqTextFiled

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (UITextField *)tf{
    if (!_tf) {
        _tf = [[UITextField alloc] init];
        _tf.placeholder = @"请输入";
        [_tf addTarget:self action:@selector(tfTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _tf;
}
- (void)tfTextDidChange:(UITextField *)tf{
    NSLog(@"tf==%@",tf.text);
    CGSize tfContentSize = tf.intrinsicContentSize;
    CGSize initContentSize = self.bounds.size;
    if (tfContentSize.width > initContentSize.width) {
        
        CGSize scrollContentSize = self.scrollView.contentSize;
        scrollContentSize.width = tfContentSize.width;
        self.scrollView.contentSize = scrollContentSize;
        
        CGRect tfFrame = tf.frame;
        tfFrame.size.width = tfContentSize.width;
        tf.frame = tfFrame;
        
    }else{
        CGSize scrollContentSize = self.scrollView.contentSize;
        scrollContentSize.width = initContentSize.width;
        self.scrollView.contentSize = scrollContentSize;
        
        CGRect tfFrame = tf.frame;
        tfFrame.size.width = initContentSize.width;
        tf.frame = tfFrame;
    }
    NSLog(@"tf.intrinsicContentSize==%@",@(tf.intrinsicContentSize));
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setup{
    self.backgroundColor = HqRandomColor;
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.tf];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.tf.frame = self.scrollView.bounds;
}

@end
