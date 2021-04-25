//
//  HqImageTitleView.h
//  HqUtils
//
//  Created by hehuiqi on 2021/4/19.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HqImageTitleStyle){
    HqImageTitleStyleIconLeft,
    HqImageTitleStyleIconRight,
    HqImageTitleStyleIconTop,
    HqImageTitleStyleIconBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface HqImageTitleView : UIControl


@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *lable;
@property(nonatomic,assign) CGFloat labIconSpace;
@property(nonatomic,assign) UIEdgeInsets contentInsets;
@property(nonatomic,assign) HqImageTitleStyle style;

@property(nonatomic,strong) UIColor *normalTextCoror;
@property(nonatomic,strong) UIColor *selectedTextCoror;

@property(nonatomic,strong) UIImage *normalImage;
@property(nonatomic,strong) UIImage *selectedImage;

@property(nonatomic,strong) UIImage *normalBackgroundImage;
@property(nonatomic,strong) UIImage *highlightedBackgroundImage;

@end


NS_ASSUME_NONNULL_END
