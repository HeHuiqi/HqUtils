//
//  HqSetCornerView.m
//  HqUtils
//
//  Created by hehuiqi on 7/3/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqSetCornerView.h"

@implementation HqSetCornerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.rectCorner = UIRectCornerAllCorners;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.hqCornerRadius>0&&self.image) {
      
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
            UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:self.rectCorner cornerRadii:CGSizeMake(self.hqCornerRadius, self.hqCornerRadius)];
            [clipPath addClip];
            [self drawRect:self.bounds];
            //当前上下文
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            // 结束上下文
            UIGraphicsEndImageContext();
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = newImage;
            });
        });
    }
  
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
