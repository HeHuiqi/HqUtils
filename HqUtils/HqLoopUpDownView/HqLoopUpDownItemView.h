//
//  HqLoopUpDownItemView.h
//  HqUtils
//
//  Created by hehuiqi on 2020/1/8.
//  Copyright © 2020 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqLoopUpDownItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqLoopUpDownItemView : UIButton

@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) HqLoopUpDownItem *item;

@end

NS_ASSUME_NONNULL_END
