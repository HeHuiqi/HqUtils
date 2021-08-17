//
//  HqArrowImage.h
//  HqUtils
//
//  Created by hehuiqi on 2021/5/28.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HqArrowImagePosition) {
    HqArrowImagePositionTop,
    HqArrowImagePositionLeft,
    HqArrowImagePositionBottom,
    HqArrowImagePositionRight,
};

typedef NS_ENUM(NSUInteger, HqArrowImageStyle) {
    HqArrowImageStyleFill,//填充
    HqArrowImageStyleStroke,//线条轮廓
};

NS_ASSUME_NONNULL_BEGIN

@interface HqArrowImage : NSObject
/**
Default CGSizeMake(8.0, 14.0)
在实际的绘制当中的Size为 width和height给加上lineWidht的一半
*/
@property(nonatomic,assign) CGSize imageSize;

//Default HqArrowImagePositionRight
@property(nonatomic,assign) HqArrowImagePosition arrowPosition;

//Default HqArrowImageStyleStroke
@property(nonatomic,assign) HqArrowImageStyle arrowStyle;

//Default [UIColor systemBlueColor]
@property(nonatomic,strong) UIColor *arrowColor;

//Default 2.0
@property(nonatomic,assign) CGFloat lineWidth;

- (UIImage *)makeImage;

+ (UIImage *)navBackImage;
+ (UIImage *)tableArrowImage;
+ (UIImage *)questionImage;

@end

NS_ASSUME_NONNULL_END
