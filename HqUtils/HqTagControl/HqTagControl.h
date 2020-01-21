//
//  HqTagControl.h
//  HqUtils
//
//  Created by hehuiqi on 2020/1/14.
//  Copyright © 2020 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,HqTagControlStyle) {
    HqTagControlStyleDefault,
    HqTagControlStyleHaveLeftIcon,
    HqTagControlStyleHaveRightIcon,
    HqTagControlStyleHaveLeftRightIcon,
};

NS_ASSUME_NONNULL_BEGIN

@interface HqTagControl : UIControl

@property(nonatomic,strong) UIImageView *rightIcon;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIImageView *leftIcon;
@property(nonatomic,assign) CGFloat iconLabSpace;
@property(nonatomic,assign) CGFloat leftRightSpace;
@property(nonatomic,assign) CGFloat topBottomSpace;
@property(nonatomic,assign) HqTagControlStyle style;

@end

NS_ASSUME_NONNULL_END
