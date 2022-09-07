//
//  HqLocalPaintVC.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "SuperVC.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HqLocalPaintVCDelegate;
@interface HqLocalPaintVC : SuperVC

@property(nonatomic,weak) id<HqLocalPaintVCDelegate> delegate;

@end

@protocol HqLocalPaintVCDelegate <NSObject>

- (void)hqLocalPaintVC:(HqLocalPaintVC *)vc paintLayer:(CAShapeLayer *)paintLayer;

@end

NS_ASSUME_NONNULL_END
