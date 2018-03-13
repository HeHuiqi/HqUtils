//
//  UIImage+HqImage.h
//  HqUtils
//
//  Created by macpro on 2018/3/13.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HqImage)

+ (UIImage *)getScreenshot:(UIView *)view;

+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

+ (UIImage*) createImageWithColor: (UIColor*) color;

@end
