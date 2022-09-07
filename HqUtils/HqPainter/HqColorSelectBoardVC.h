//
//  HqColorSelectBoardVC.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "SuperVC.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HqColorSelectBoardVCDelegate;

@interface HqColorSelectBoardVC : SuperVC

@property(nonatomic,weak) id<HqColorSelectBoardVCDelegate> delegate;
@property(nonatomic,strong) UIColor *currentColor;
@property(nonatomic,assign) CGFloat lineWidth;

@end

@protocol HqColorSelectBoardVCDelegate <NSObject>

@optional
- (void)hqColorSelectBoardVC:(HqColorSelectBoardVC *)vc selectColor:(UIColor *)color;


@end

NS_ASSUME_NONNULL_END
