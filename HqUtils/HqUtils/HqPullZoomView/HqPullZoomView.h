//
//  HqPullZoomView.h
//  GlobalPay
//
//  Created by hqmac on 2018/8/23.
//  Copyright © 2018年 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HqPullZoomView : UIView

@property(nonatomic,assign) CGFloat initHeight;
@property(nonatomic,assign) CGFloat initY;
@property(nonatomic,strong) UIImage *bgImage;
@property (nonatomic,strong) UIScrollView *scrollView;

- (UIImage *)createImageWithGradientcolors:(NSArray *)colros rect:(CGRect)rect;

@end
