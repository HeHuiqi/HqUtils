//
//  HqImageBrowserCell.m
//  HqUtils
//
//  Created by hehuiqi on 11/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqImageBrowserCell.h"

@interface HqImageBrowserCell ()<UIScrollViewDelegate>

@end

@implementation HqImageBrowserCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView  = [[UIScrollView alloc] init];
        _contentScrollView.delegate = self;
        _contentScrollView.minimumZoomScale = 1.0;
        _contentScrollView.maximumZoomScale = 2.0;
        _contentScrollView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tap];
    }
    return _contentScrollView;
}
- (void)tapView:(UITapGestureRecognizer *)tap{
//    [self dismissView];
    if ([self.delegate respondsToSelector:@selector(tapDismissView:)] && self.delegate) {
        [self.delegate tapDismissView:self];
    }
    
}
- (UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    }
    return _activityView;
}
- (UIImageView *)bigImageView{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] init];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bigImageView.backgroundColor = [UIColor grayColor];
//        UIImage *image = [UIImage imageNamed:@"yazi.jpeg"];
//        _bigImageView.image = image;
    }
    return _bigImageView;
}
- (CGRect)thumbOriginalViewRect{
    if (self.thumbImageView) {
        if ([self.thumbImageView.superview isEqual:self.superview]) {
            return self.thumbImageView.frame;
        }else{
            UIView *inView = [UIApplication sharedApplication].keyWindow;
            CGRect rect = [self.thumbImageView convertRect:self.thumbImageView.bounds toView:inView];
            return rect;
        }
    }
    return CGRectZero;
}
- (void)setup{
    [self addSubview:self.contentScrollView];
    self.contentScrollView.frame = [UIScreen mainScreen].bounds;
    [self.contentScrollView addSubview:self.bigImageView];
    [self addSubview:self.activityView];
    
}
- (UIImage *)thumbImage{
    if (_thumbImage) {
        return _thumbImage;
    }
    return self.thumbImageView.image;
}
- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    if (_imageUrl) {
        NSURL *url = [NSURL URLWithString:imageUrl];
        [self showWiththumbImageView:self.thumbImageView];
        [self.activityView startAnimating];
        [self.bigImageView sd_setImageWithURL:url placeholderImage:self.thumbImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                CGFloat hwScale = image.size.height/image.size.width;
                CGFloat imageW = self.contentScrollView.bounds.size.width;
                CGFloat imageH = hwScale>0 ? imageW*hwScale : imageW;
                
                self.bigImageView.bounds = CGRectMake(0, 0, imageW, imageH);
                NSLog(@"self.bigImageView.bound==%@",NSStringFromCGRect(self.bigImageView.bounds));

            }
            [self.activityView stopAnimating];
        }];
        
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.activityView.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
}
- (void)showWiththumbImageView:(UIImageView * _Nullable)thumbImageView{
    
    if (thumbImageView) {
        self.thumbImageView = thumbImageView;
        self.bigImageView.frame = self.thumbOriginalViewRect;
//        NSLog(@"thumbOriginalViewRect==%@",NSStringFromCGRect(self.thumbOriginalViewRect));
       self.thumbImage = thumbImageView.image;
    }
    
    CGFloat hwScale = self.thumbImage.size.height/self.thumbImage.size.width;
    CGFloat imageH = hwScale>0 ? self.contentScrollView.bounds.size.width*hwScale : self.contentScrollView.bounds.size.width;
    CGFloat imageW = self.contentScrollView.bounds.size.width;

    if (thumbImageView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bigImageView.center = self.contentScrollView.center;
            self.bigImageView.bounds = CGRectMake(0, 0, imageW, imageH);
//            self.backgroundColor = [UIColor blackColor];
        }];
    }else{
        self.bigImageView.center = self.contentScrollView.center;
        self.bigImageView.bounds = CGRectMake(0, 0, imageW, imageH);
    }
}
#pragma amrk - UIScrollViewDelegate
//外部处理
- (void)dismissView{
    if (self.thumbImageView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bigImageView.frame = self.thumbOriginalViewRect;
            self.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.bigImageView.alpha = 0;
            self.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.bigImageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {

    
    CGRect imageViewFrame = self.bigImageView.frame;
    CGFloat width = imageViewFrame.size.width,
    height = imageViewFrame.size.height,
    sHeight = scrollView.bounds.size.height,
    sWidth = scrollView.bounds.size.width;
    if (height > sHeight) {
        imageViewFrame.origin.y = 0;
    } else {
        imageViewFrame.origin.y = (sHeight - height) / 2.0;
    }
    if (width > sWidth) {
        imageViewFrame.origin.x = 0;
    } else {
        imageViewFrame.origin.x = (sWidth - width) / 2.0;
    }
    self.bigImageView.frame = imageViewFrame;
}


@end
