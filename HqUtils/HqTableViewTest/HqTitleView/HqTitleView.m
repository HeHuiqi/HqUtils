//
//  HqTitleView.m
//  HqTabTest
//
//  Created by hehuiqi on 8/17/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import "HqTitleView.h"

@implementation HqTitleView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.changeHeight = frame.size.height;
        [self setup];
    }
    return self;
}
- (void)dealloc{
    if (self.scollView) {
        [self.scollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}
- (void)setup{
 
    [self addSubview:self.titleLab];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.userIcon];
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLab.font = [UIFont boldSystemFontOfSize:18];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
       // _contentView.backgroundColor = [UIColor colorWithWhite:255/255.0 alpha:0.1];
        _contentView.alpha = 0.0;
    }
    return _contentView;
}
- (UIImageView *)userIcon{
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] init];
        _userIcon.backgroundColor = [UIColor lightGrayColor];
        _userIcon.contentMode = UIViewContentModeScaleAspectFill;
        _userIcon.clipsToBounds = YES;
    }
    return _userIcon;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title) {
        self.titleLab.text = title;
    }
}
- (void)setScollView:(UIScrollView *)scollView{
    _scollView = scollView;
    if (_scollView) {
      
        [scollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:NULL];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLab.frame = self.bounds;
    self.contentView.frame = self.bounds;
    
    CGFloat userIconW = self.bounds.size.height - 10;
    CGFloat userIconH = userIconW;
    self.userIcon.bounds = CGRectMake(0, 0, userIconW, userIconH);
    self.userIcon.center = self.contentView.center;
    self.userIcon.layer.cornerRadius = userIconW/2.0;
}


#pragma mark - 监听UIScrollVie的contentOffset
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //NSLog(@"change == %@",change);
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat alpha = offset.y/self.changeHeight;
        self.titleLab.alpha = 1-alpha;
        self.contentView.alpha = alpha;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

///

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
