//
//  HqPainterToolBar.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqPainterToolBar : UIView

@property(nonatomic,strong) UIButton *openBtn;
@property(nonatomic,strong) UIButton *saveBtn;

@property(nonatomic,strong) UIButton *undoBtn;
@property(nonatomic,strong) UIButton *redoBtn;
@property(nonatomic,strong) UIButton *setBtn;


- (void)hqAddTarget:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
