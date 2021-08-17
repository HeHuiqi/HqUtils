//
//  HqLableButton.h
//  HqUtils
//
//  Created by hehuiqi on 2021/4/25.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HqLableAlign) {
    HqLableAlignLeft,
    HqLableAlignCenter,
    HqLableAlignRight,
};
NS_ASSUME_NONNULL_BEGIN

@interface HqLableButton : UIControl

@property(nonatomic,assign) HqLableAlign lableAlign;
@property(nonatomic,assign) UIEdgeInsets contentInsets;
@property(nonatomic,assign) CGFloat labSpace;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *contentLab;


@end

NS_ASSUME_NONNULL_END
