//
//  HqUIButton.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/19.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqUIButton.h"

@implementation HqUIButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imagePosition = HqUIButtonImagePositionLeft;
        self.imageLabelSpace = 5;
        [self setup];
    }
    return self;
}

- (void)setup{
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    
}
- (CGFloat)imageLabelSpace{
    if (self.currentImage == nil) {
        return 0;
    }
    return _imageLabelSpace;
}
- (UIEdgeInsets)imageEdgeInsets{
    return UIEdgeInsetsZero;
}
- (UIEdgeInsets)titleEdgeInsets{
    return UIEdgeInsetsZero;
}

- (CGSize)intrinsicContentSize{
    CGSize imageSize = self.imageView.intrinsicContentSize;
    CGFloat imageLabelSpace = self.imageLabelSpace;
    if (self.currentImage == nil) {
        imageSize = CGSizeZero;
    }
    CGSize lableSize = self.titleLabel.intrinsicContentSize;

    if (self.imagePosition == HqUIButtonImagePositionTop ||
        self.imagePosition == HqUIButtonImagePositionBottom) {
        //垂直布局取width最大者
//        CGFloat width = fmax(imageSize.width, lableSize.width);
        CGFloat width = fmax(imageSize.width, lableSize.width);


        CGFloat height = imageSize.height + lableSize.height;

        width = width + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
        height = height + imageLabelSpace +  self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
        return CGSizeMake(width, height);
        
    }
    CGFloat width = imageSize.width + lableSize.width;
    //水平布局取height最大者
    CGFloat height = fmax(imageSize.height, lableSize.height);
    width = width + imageLabelSpace + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    height = height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
    
    return CGSizeMake(width, height);
}
- (void)layoutSubviews{
    [super layoutSubviews];

    switch (self.imagePosition) {
        case HqUIButtonImagePositionLeft:
        {
            [self imageViewAtLeft];
        }
            break;
        case HqUIButtonImagePositionRight:
        {
            [self imageViewAtRight];
        }
            break;
        case HqUIButtonImagePositionTop:
        {
            [self imageViewAtTop];
        }
            break;
        case HqUIButtonImagePositionBottom:
        {
            [self imageViewAtBottom];
        }
            break;
        default:
            break;
    }

    
}
- (void)imageViewAtLeft{
    CGRect imageViewRect = self.imageView.frame;
    imageViewRect.origin.x = self.contentEdgeInsets.left;
    self.imageView.frame = imageViewRect;
    
    CGRect titleLableFrame = self.titleLabel.frame;
    titleLableFrame.origin.x = CGRectGetMaxX(imageViewRect)+self.imageLabelSpace;
    self.titleLabel.frame = titleLableFrame;
}
- (void)imageViewAtRight{
    
    CGRect titleLableFrame = self.titleLabel.frame;
    titleLableFrame.origin.x = self.contentEdgeInsets.left;
    self.titleLabel.frame = titleLableFrame;
    
    CGRect imageViewRect = self.imageView.frame;
    imageViewRect.origin.x = CGRectGetMaxX(titleLableFrame)+self.imageLabelSpace;
    self.imageView.frame = imageViewRect;

}
- (void)imageViewAtTop{
    
    CGFloat width = self.bounds.size.width;

    
    CGSize imageSize = self.imageView.intrinsicContentSize;
    CGFloat imageLabelSpace = self.imageLabelSpace;
    if (self.currentImage == nil) {
        imageSize = CGSizeZero;
    }
    CGSize lableSize = self.titleLabel.intrinsicContentSize;
    
    CGRect imageViewRect = self.imageView.frame;
    imageViewRect.origin.x = (width - imageSize.width)/2.0;
    imageViewRect.origin.y = self.contentEdgeInsets.top;
    imageViewRect.size = imageSize;
    self.imageView.frame = imageViewRect;
    
    CGRect titleLableFrame = self.titleLabel.frame;
    titleLableFrame.origin.x = (width - lableSize.width)/2.0;
    titleLableFrame.origin.y = CGRectGetMaxY(imageViewRect) + imageLabelSpace;
    titleLableFrame.size = lableSize;
    
    self.titleLabel.frame = titleLableFrame;

}
- (void)imageViewAtBottom{
    
    CGFloat width = self.bounds.size.width;

    CGSize imageSize = self.imageView.intrinsicContentSize;
    CGFloat imageLabelSpace = self.imageLabelSpace;
    if (self.currentImage == nil) {
        imageSize = CGSizeZero;
    }
    CGSize lableSize = self.titleLabel.intrinsicContentSize;
    
    
    CGRect titleLableFrame = self.titleLabel.frame;
    titleLableFrame.origin.x = (width - lableSize.width)/2.0;
    titleLableFrame.origin.y = self.contentEdgeInsets.top;
    titleLableFrame.size = lableSize;
    self.titleLabel.frame = titleLableFrame;
    
    CGRect imageViewRect = self.imageView.frame;
    imageViewRect.origin.x = (width - imageSize.width)/2.0;
    imageViewRect.origin.y = CGRectGetMaxY(titleLableFrame) + imageLabelSpace;
    imageViewRect.size = imageSize;
    self.imageView.frame = imageViewRect;

}
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5;
    }else{
        self.alpha = 1.0;
    }
}

@end
