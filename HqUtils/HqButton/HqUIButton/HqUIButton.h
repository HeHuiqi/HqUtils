//
//  HqUIButton.h
//  HqUtils
//
//  Created by hehuiqi on 2021/4/19.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HqUIButtonImagePosition){
    HqUIButtonImagePositionLeft,
    HqUIButtonImagePositionRight,
    HqUIButtonImagePositionTop,
    HqUIButtonImagePositionBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface HqUIButton : UIButton

@property(nonatomic,assign) HqUIButtonImagePosition imagePosition;
@property(nonatomic,assign) CGFloat imageLabelSpace;

@property(nonatomic,copy) NSString *normalTitle;
@property(nonatomic,copy) NSString *selectedTitle;

@property(nonatomic,strong) UIColor *normalTitleColor;
@property(nonatomic,strong) UIColor *selectedTitleColor;

@property(nonatomic,strong) UIImage *normalImage;
@property(nonatomic,strong) UIImage *selectedImage;


@end

NS_ASSUME_NONNULL_END
