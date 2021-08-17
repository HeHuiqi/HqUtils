//
//  HqButton.h
//  HqUtils
//
//  Created by hehuiqi on 2021/4/19.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HqButtonStyle){
    HqButtonStyleIconLeft,
    HqButtonStyleIconRight,
    HqButtonStyleIconTop,
    HqButtonStyleIconBottom,
    HqButtonStyleOnlyShowIcon,
    HqButtonStyleOnlyShowLab
};

NS_ASSUME_NONNULL_BEGIN

@interface HqButton : UIControl


@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *lable;
@property(nonatomic,assign) CGFloat labIconSpace;
@property(nonatomic,assign) UIEdgeInsets contentInsets;
@property(nonatomic,assign) HqButtonStyle style;

@property(nonatomic,strong) UIColor *normalTextColor;
@property(nonatomic,strong) UIColor *selectedTextColor;

@property(nonatomic,strong) UIImage *normalImage;
@property(nonatomic,strong) UIImage *selectedImage;

@property(nonatomic,strong) UIColor *disEanbleTextColor;
@property(nonatomic,strong) UIImage *disEnableImage;

@property(nonatomic,strong) UIImage *normalBackgroundImage;
@property(nonatomic,strong) UIImage *highlightedBackgroundImage;

@end


NS_ASSUME_NONNULL_END
