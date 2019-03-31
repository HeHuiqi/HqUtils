//
//  UIView+HqSetCorner.h
//  HqUtils
//
//  Created by hqmac on 2019/3/8.
//  Copyright © 2019 macpro. All rights reserved.
//
//
#import <UIKit/UIKit.h>

// TODO:通过监听layoutSubview方法来动态更改圆角设置

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, HQUIRectCorner) {
    HQUIRectCornerAllCorners  = -1,
    HQUIRectCornerTopLeft     = UIRectCornerTopLeft,
    HQUIRectCornerTopRight    = UIRectCornerTopRight,
    HQUIRectCornerBottomLeft  = UIRectCornerBottomLeft,
    HQUIRectCornerBottomRight = UIRectCornerBottomRight,
};

@interface UIView (HqSetCorner)


@property (nonatomic,assign) CGFloat hqRaduis;
@property (nonatomic,assign) HQUIRectCorner hqCorner;

//注意：当视图大小变更时需要重新调用设置圆角方法

//设置四边圆角
- (void)hqSetCornerRaduis:(CGFloat)raduis;

//指定一边或多边圆角
// 如：UIRectCornerTopLeft | UIRectCornerTopRight 表示设置左上和右上的圆角
- (void)hqSetCorner:(HQUIRectCorner)corner raduis:(CGFloat)raduis;

@end

NS_ASSUME_NONNULL_END
