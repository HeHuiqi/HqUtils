//
//  HqImageTitleView.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/19.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqImageTitleView.h"



@interface HqImageTitleView ()

@property(nonatomic,strong) UIImageView *backGroundImageView;

@end


@implementation HqImageTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.labIconSpace = 5;
        self.style = HqImageTitleStyleIconLeft;
        [self setup];
    }
    return self;
}
- (UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc] init];
    }
    return _backGroundImageView;
}



- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}
- (UILabel *)lable{
    if (!_lable) {
        _lable = [[UILabel alloc] init];
        _lable.font = [UIFont systemFontOfSize:15];
    }
    return _lable;
}
- (void)setup{
    [self addSubview:self.backGroundImageView];
    [self addSubview:self.icon];
    [self addSubview:self.lable];

}

- (CGSize)intrinsicContentSize{

    CGSize size = [super intrinsicContentSize];
    CGSize iconSize = self.icon.intrinsicContentSize;
    CGSize lableSize = self.lable.intrinsicContentSize;
    NSLog(@"iconSize==%@",@(iconSize));
    NSLog(@"lableSize==%@",@(lableSize));
    
    //UIImageView的intrinsicContentSize默认值是CGSizeMake(-1, -1)
    //所有要修正一下
    if (CGSizeEqualToSize(iconSize, CGSizeMake(-1, -1))) {
        iconSize = CGSizeZero;
    }
    
    size.width = iconSize.width + lableSize.width;
    size.height = iconSize.height + lableSize.height;
    
    if (self.style == HqImageTitleStyleIconLeft ||
        self.style == HqImageTitleStyleIconRight) {
        CGFloat labIconSpace = self.labIconSpace;
        if (self.normalImage == nil || self.lable.text.length == 0) {
            labIconSpace = 0;
        }
        size.width = size.width + labIconSpace;

    }
    if (self.style == HqImageTitleStyleIconTop ||
        self.style == HqImageTitleStyleIconBottom) {
        CGFloat labIconSpace = self.labIconSpace;
        if (self.normalImage == nil || self.lable.text.length == 0) {
            labIconSpace = 0;
        }
        size.height = size.height + labIconSpace;

    }
    if (!UIEdgeInsetsEqualToEdgeInsets(self.contentInsets, UIEdgeInsetsZero)) {
        size.width = size.width + self.contentInsets.left + self.contentInsets.right;
        size.height = size.height + self.contentInsets.top + self.contentInsets.bottom;
    }
    NSLog(@"intrinsicContentSize==%@",@(size));
    
    return size;
    
}
- (void)setNormalTextCoror:(UIColor *)normalTextCoror{
    _normalTextCoror = normalTextCoror;
    self.lable.textColor = normalTextCoror;
}
- (void)setNormalImage:(UIImage *)normalImage{
    _normalImage = normalImage;
    self.icon.image = normalImage;
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    UIImage *selectedImage = self.selectedImage;
    if (selectedImage == nil) {
        selectedImage = self.normalImage;
    }
    UIImage *image = selected ? selectedImage:self.normalImage;
    self.icon.image = image;
    UIColor *selectedTextColor = self.selectedTextCoror;
    if (selectedTextColor == nil) {
        selectedTextColor = self.normalTextCoror;
    }
    UIColor *textColor = selected ? selectedTextColor : self.normalTextCoror;
    self.lable.textColor = textColor;
}

- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage{
    _normalBackgroundImage = normalBackgroundImage;
    self.backGroundImageView.image = normalBackgroundImage;
}
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (self.highlightedBackgroundImage && self.normalBackgroundImage) {
        UIImage *image = highlighted ? self.highlightedBackgroundImage:self.normalBackgroundImage;
        self.backGroundImageView.image = image;
    }else{
        if (highlighted) {
            self.alpha = 0.5;
        }else{
            self.alpha = 1.0;
        }
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backGroundImageView.frame = self.bounds;
    switch (self.style) {
        case HqImageTitleStyleIconLeft:
        {
            [self iconLeftLayout];
        }
            break;
            
        case HqImageTitleStyleIconRight:
        {
            [self iconRightLayout];
        }
            break;
        case HqImageTitleStyleIconTop:
        {
            [self iconTopLayout];
        }
            break;
        case HqImageTitleStyleIconBottom:
        {
            [self iconBottomLayout];
        }
            break;
            
        default:
            break;
    }
    
}
- (void)iconLeftLayout{
    CGSize iconSize = self.icon.intrinsicContentSize;
    CGSize lableSize = self.lable.intrinsicContentSize;
    
    CGFloat iconX = self.contentInsets.left;
    CGFloat iconY = (self.bounds.size.height - iconSize.height)/2.0;
    
    CGFloat labIconSpace = self.labIconSpace;
    if (self.normalImage == nil) {
        self.icon.frame = CGRectMake(iconX, iconY, 0, 0);
        labIconSpace = 0;
    }else{
        self.icon.frame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    }

    CGFloat lableX = CGRectGetMaxX(self.icon.frame)+labIconSpace;

    CGFloat lableY = (self.bounds.size.height - lableSize.height)/2.0;
    
    CGFloat maxlableW = self.bounds.size.width -  lableX;
    CGFloat lableW = lableSize.width;
    if (lableW > maxlableW) {
        lableW = maxlableW;
    }
    self.lable.frame = CGRectMake(lableX, lableY, lableW, lableSize.height);
}
- (void)iconRightLayout{
    
    CGSize iconSize = self.icon.intrinsicContentSize;
    CGSize lableSize = self.lable.intrinsicContentSize;

    CGFloat lableMaxW = self.bounds.size.width - iconSize.width - self.contentInsets.left - self.contentInsets.right;
    CGFloat lableW = lableSize.width;
    if (lableW > lableMaxW) {
        lableW = lableMaxW;
    }
    CGFloat lableX = self.contentInsets.left;
    CGFloat lableY = (self.bounds.size.height - lableSize.height)/2.0;
    
    CGFloat labIconSpace = self.labIconSpace;
    if (self.lable.text.length == 0) {
        labIconSpace = 0;
        self.lable.frame = CGRectMake(lableX, 0, 0, 0);
    }else{
        self.lable.frame = CGRectMake(lableX, lableY, lableW, lableSize.height);
    }

    CGFloat iconX = CGRectGetMaxX(self.lable.frame)+labIconSpace;
    CGFloat iconY = (self.bounds.size.height - iconSize.height)/2.0;
    self.icon.frame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
}
- (void)iconTopLayout{
    CGSize iconSize = self.icon.intrinsicContentSize;
    CGSize lableSize = self.lable.intrinsicContentSize;
    
    CGFloat iconX = (self.bounds.size.width - iconSize.width)/2.0;
    CGFloat iconY = self.contentInsets.top;
    CGFloat labIconSpace = self.labIconSpace;
    if (self.normalImage == nil) {
        self.icon.frame = CGRectMake(iconX, iconY, 0, 0);
        labIconSpace = 0;
    }else{
        self.icon.frame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    }
    
    CGFloat maxlableW = self.bounds.size.width;
    CGFloat lableW = lableSize.width;
    if (lableW > maxlableW) {
        lableW = maxlableW;
    }
    CGFloat lableX = (self.bounds.size.width - lableW)/2.0;
    CGFloat lableY = CGRectGetMaxY(self.icon.frame) + labIconSpace;
    self.lable.frame = CGRectMake(lableX, lableY, lableW,lableSize.height);

}
- (void)iconBottomLayout{
    CGSize iconSize = self.icon.intrinsicContentSize;
    CGSize lableSize = self.lable.intrinsicContentSize;
    
    CGFloat maxlableW = self.bounds.size.width;
    CGFloat lableW = lableSize.width;
    if (lableW > maxlableW) {
        lableW = maxlableW;
    }
    
    
    CGFloat lableX = (self.bounds.size.width - lableW)/2.0;
    CGFloat lableY = self.contentInsets.top;
    
    CGFloat labIconSpace = self.labIconSpace;
    if (self.lable.text.length == 0) {
        labIconSpace = 0;
        self.lable.frame = CGRectMake(0, lableY, 0, 0);
    }else{
        self.lable.frame = CGRectMake(lableX, lableY, lableW, lableSize.height);
    }
    
    CGFloat iconX = (self.bounds.size.width - iconSize.width)/2.0;
    CGFloat iconY = CGRectGetMaxY(self.lable.frame)+labIconSpace;
    self.icon.frame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    
}


@end
