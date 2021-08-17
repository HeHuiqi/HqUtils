//
//  HqButton.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/19.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqButton.h"

@interface HqButton ()

@property(nonatomic,strong) UIImageView *backGroundImageView;
@property(nonatomic,assign) CGSize iconIntrinsicContentSize;
@property(nonatomic,assign) CGSize lableIntrinsicContentSize;

@end


@implementation HqButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.labIconSpace = 5;
        self.style = HqButtonStyleIconLeft;
        [self setup];
    }
    return self;
}
- (void)dealloc{
    [self.lable removeObserver:self forKeyPath:@"text"];
    [self.icon removeObserver:self forKeyPath:@"image"];
}
- (UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc] init];
    }
    return _backGroundImageView;
}


- (CGSize)iconIntrinsicContentSize{
    CGSize iconSize = self.icon.intrinsicContentSize;
    if (CGSizeEqualToSize(iconSize, CGSizeMake(-1, -1))) {
        iconSize = CGSizeZero;
    }
    return iconSize;
}
- (CGSize)lableIntrinsicContentSize{
    CGSize lableSize = self.lable.intrinsicContentSize;
    if (CGSizeEqualToSize(lableSize, CGSizeMake(-1, -1))) {
        lableSize = CGSizeZero;
    }
    return lableSize;
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
    
    [self.lable addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew) context:nil];
    [self.icon addObserver:self forKeyPath:@"image" options:(NSKeyValueObservingOptionNew) context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"] ||
        [keyPath isEqualToString:@"image"]) {
        NSLog(@"observeValueForKeyPath--%@",keyPath);
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }
}

- (CGSize)intrinsicContentSize{

    CGSize size = [super intrinsicContentSize];
    CGSize iconSize = self.iconIntrinsicContentSize;
    CGSize lableSize = self.lableIntrinsicContentSize;
//    NSLog(@"iconSize==%@",@(iconSize));
//    NSLog(@"lableSize==%@",@(lableSize));
    //UIImageView的intrinsicContentSize默认值是CGSizeMake(-1, -1)
    //所有要修正一下

    if (self.style == HqButtonStyleIconLeft ||
        self.style == HqButtonStyleIconRight) {
        CGFloat labIconSpace = self.labIconSpace;
        if (self.normalImage == nil || self.lable.text.length == 0) {
            labIconSpace = 0;
        }
        size.width = iconSize.width + lableSize.width;
        size.height = MAX(iconSize.height, lableSize.height);
        size.width = size.width + labIconSpace;

    }
    if (self.style == HqButtonStyleIconTop ||
        self.style == HqButtonStyleIconBottom) {
        CGFloat labIconSpace = self.labIconSpace;
        if (self.normalImage == nil || self.lable.text.length == 0) {
            labIconSpace = 0;
        }
        size.width = MAX(iconSize.width, lableSize.width);
        size.height = iconSize.height + lableSize.height;
        size.height = size.height + labIconSpace;

    }
    if (self.style == HqButtonStyleOnlyShowIcon) {
        size.width = iconSize.width;
        size.height = iconSize.height;
    }
    if (self.style == HqButtonStyleOnlyShowLab) {
        size.width = lableSize.width;
        size.height = lableSize.height;
    }
    size.width = size.width + self.contentInsets.left + self.contentInsets.right;
    size.height = size.height + self.contentInsets.top + self.contentInsets.bottom;
    NSLog(@"intrinsicContentSize==%@",@(size));
    
    return size;
    
}
- (void)setNormalTextColor:(UIColor *)normalTextColor{
    _normalTextColor = normalTextColor;
    self.lable.textColor = normalTextColor;
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
    UIColor *selectedTextColor = self.selectedTextColor;
    if (selectedTextColor == nil) {
        selectedTextColor = self.normalTextColor;
    }
    UIColor *textColor = selected ? selectedTextColor : self.normalTextColor;
    self.lable.textColor = textColor;
}
- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    if (enabled) {
        self.selected = self.selected;
    }else{
        if (self.disEnableImage) {
            self.icon.image = self.disEnableImage;
        }
        if (self.disEanbleTextColor) {
            self.lable.textColor = self.disEanbleTextColor;
        }
    }
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
    NSLog(@"layoutSubviews");
    switch (self.style) {
        case HqButtonStyleIconLeft:
        {
            [self iconLeftLayout];
        }
            break;
            
        case HqButtonStyleIconRight:
        {
            [self iconRightLayout];
        }
            break;
        case HqButtonStyleIconTop:
        {
            [self iconTopLayout];
        }
            break;
        case HqButtonStyleIconBottom:
        {
            [self iconBottomLayout];
        }
            break;
        case HqButtonStyleOnlyShowIcon:
        {
            [self onlyShowIconLayout];
        }
            break;
        case HqButtonStyleOnlyShowLab:
        {
            [self onlyShowLabLayout];
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
    
    CGFloat maxlableW = self.bounds.size.width -  lableX - self.contentInsets.right;
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

- (void)onlyShowIconLayout{
    
    CGSize iconSize = self.icon.intrinsicContentSize;
    
    CGFloat iconX = (self.bounds.size.width - iconSize.width)/2.0;
    CGFloat iconY = (self.bounds.size.height - iconSize.height)/2.0;
    
    self.icon.frame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    self.lable.frame = CGRectZero;

}

- (void)onlyShowLabLayout{
    
    CGSize lableSize = self.lableIntrinsicContentSize;

    CGFloat lableMaxW = self.bounds.size.width - self.contentInsets.left - self.contentInsets.right;
    CGFloat lableW = lableSize.width;
    if (lableW > lableMaxW) {
        lableW = lableMaxW;
    }
    CGFloat lableX = (self.bounds.size.width - lableW)/2.0;
    CGFloat lableY = (self.bounds.size.height - lableSize.height)/2.0;
    self.lable.frame = CGRectMake(lableX, lableY, lableW, lableSize.height);
    self.icon.frame = CGRectZero;
}
- (void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    if (self.icon.image) {
        UIImage *image =  self.icon.image;

        if (@available(iOS 13.0, *)) {
            image = [image imageWithTintColor:tintColor renderingMode:(UIImageRenderingModeAlwaysTemplate)];
        } else {
            image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        }
        self.icon.image = image;
        self.icon.tintColor = tintColor;
    }
    if (self.lable.text) {
        self.lable.textColor = tintColor;
    }
}


@end
