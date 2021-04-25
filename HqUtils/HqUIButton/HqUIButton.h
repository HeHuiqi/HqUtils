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

@end

NS_ASSUME_NONNULL_END
