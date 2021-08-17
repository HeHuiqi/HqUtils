//
//  HqLableButton.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/25.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqLableButton.h"

@implementation HqLableButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = SetFont(kZoomValue(14));
    }
    return _titleLab;
}
- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = SetFont(kZoomValue(14));
    }
    return _contentLab;
}
- (void)setup{
    _lableAlign = HqLableAlignLeft;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.titleLab];
    [self addSubview:self.contentLab];

    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5;
    }else{
        self.alpha = 1.0;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    switch (self.lableAlign) {
        case HqLableAlignLeft:
        {
            self.titleLab.textAlignment = NSTextAlignmentLeft;
            self.contentLab.textAlignment = NSTextAlignmentLeft;
        }
            break;
        case HqLableAlignCenter:
        {
            self.titleLab.textAlignment = NSTextAlignmentCenter;
            self.contentLab.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case HqLableAlignRight:
        {
            self.titleLab.textAlignment = NSTextAlignmentRight;
            self.contentLab.textAlignment = NSTextAlignmentRight;
        }
            break;
            
        default:
            break;
    }
    [self lablesLayout];
    
}
- (CGSize)intrinsicContentSize{
    CGSize size = [super intrinsicContentSize];
    CGSize titleSize = self.titleLab.intrinsicContentSize;
    CGSize contentSize = self.contentLab.intrinsicContentSize;
    CGFloat maxWidth = MAX(titleSize.width, contentSize.width);
    size.width = maxWidth + self.contentInsets.left + self.contentInsets.right;
    size.height = titleSize.height + self.labSpace + contentSize.height + self.contentInsets.top + self.contentInsets.bottom;
    return size;
}
- (void)lablesLayout{
 
    CGFloat labMaxWidth = self.bounds.size.width - self.contentInsets.left - self.contentInsets.right;
    CGSize titleSize = self.titleLab.intrinsicContentSize;
    CGSize contentSize = self.contentLab.intrinsicContentSize;
    CGFloat titleLabY = self.contentInsets.top;
    CGFloat titleLabX = self.contentInsets.left;

    self.titleLab.frame = CGRectMake(titleLabX, titleLabY, labMaxWidth, titleSize.height);
    CGFloat contentLabY = CGRectGetMaxY(self.titleLab.frame)+self.labSpace;
    self.contentLab.frame = CGRectMake(titleLabX, contentLabY, labMaxWidth, contentSize.height);
    
}

@end
