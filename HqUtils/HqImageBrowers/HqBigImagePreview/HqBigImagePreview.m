//
//  HqBigImagePreview.m
//  HqUtils
//
//  Created by hehuiqi on 11/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqBigImagePreview.h"
@interface HqBigImagePreview ()<UIScrollViewDelegate>
@end

@implementation HqBigImagePreview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIImageView *)bigImageView{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] init];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image = [UIImage imageNamed:@"yazi.jpeg"];
        _bigImageView.image = image;
    }
    return _bigImageView;
}
- (void)setup{
    self.delegate = self;
    self.minimumZoomScale = 1.0;
    self.maximumZoomScale = 2.0;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bigImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self addGestureRecognizer:tap];
}
- (void)tapView:(UITapGestureRecognizer *)tap{
    [self dismissView];
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
- (void)showInView:(UIView * _Nullable)inView thumbImageView:(UIImageView * _Nullable)thumbImageView{
    
    if (!inView) {
         inView = [UIApplication sharedApplication].keyWindow;
     }
    if (thumbImageView) {
        self.thumbImageView = thumbImageView;
        /*
        if ([thumbImageView.superview isEqual:inView]) {
            self.thumbOriginalViewRect = thumbImageView.frame;
        }else{
            CGRect rect = [thumbImageView convertRect:thumbImageView.bounds toView:inView];
            self.thumbOriginalViewRect = rect;
        }
        */
        
        self.bigImageView.frame = self.thumbOriginalViewRect;
        NSLog(@"thumbOriginalViewRect==%@",NSStringFromCGRect(self.thumbOriginalViewRect));
       self.thumbImage = thumbImageView.image;
    }
 
    self.frame = inView.bounds;
    [inView addSubview:self];
    
    CGFloat hwScale = self.thumbImage.size.height/self.thumbImage.size.width;
    CGFloat imageH = hwScale>0 ? self.bounds.size.width*hwScale : 250;
    if (thumbImageView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bigImageView.center = self.center;
            self.bigImageView.bounds = CGRectMake(0, 0, self.bounds.size.width, imageH);
            self.backgroundColor = [UIColor blackColor];
        }];
    }else{
        self.bigImageView.bounds = CGRectMake(0, 0, self.bounds.size.width, imageH);
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor blackColor];
        }];
    }

}

- (void)showWiththumbImageView:(UIImageView * _Nullable)thumbImageView{
    
    if (thumbImageView) {
        self.thumbImageView = thumbImageView;
        /*
        if ([thumbImageView.superview isEqual:inView]) {
            self.thumbOriginalViewRect = thumbImageView.frame;
        }else{
            CGRect rect = [thumbImageView convertRect:thumbImageView.bounds toView:inView];
            self.thumbOriginalViewRect = rect;
        }
        */
        
        self.bigImageView.frame = self.thumbOriginalViewRect;
        NSLog(@"thumbOriginalViewRect==%@",NSStringFromCGRect(self.thumbOriginalViewRect));
       self.thumbImage = thumbImageView.image;
    }
    
    CGFloat hwScale = self.thumbImage.size.height/self.thumbImage.size.width;
    CGFloat imageH = hwScale>0 ? self.bounds.size.width*hwScale : 250;
    if (thumbImageView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.bigImageView.center = self.center;
            self.bigImageView.bounds = CGRectMake(0, 0, self.bounds.size.width, imageH);
            self.backgroundColor = [UIColor blackColor];
        }];
    }else{
        self.bigImageView.bounds = CGRectMake(0, 0, self.bounds.size.width, imageH);
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor blackColor];
        }];
    }

}
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
