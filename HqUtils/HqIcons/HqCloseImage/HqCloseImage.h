//
//  HqCloseImage.h
//  HqUtils
//
//  Created by hehuiqi on 2021/5/28.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HqCloseImageStyle) {
    HqCloseImageStyleDefault,
    HqCloseImageStyleHaveCircleBorder,
};

NS_ASSUME_NONNULL_BEGIN

@interface HqCloseImage : NSObject

@property(nonatomic,assign) CGSize imageSize;
@property(nonatomic,assign) HqCloseImageStyle closeStyle;
@property(nonatomic,strong) UIColor *closeColor;
@property(nonatomic,assign) CGFloat lineWidth;

- (UIImage *)makeImage;

@end


NS_ASSUME_NONNULL_END
