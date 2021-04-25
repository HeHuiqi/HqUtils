//
//  HqTabBar.h
//  HqUtils
//
//  Created by hehuiqi on 2021/3/16.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqTabCenterView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqCustomTabBar : UITabBar

@property (nonatomic,strong) HqTabCenterView *centerView;

@end

NS_ASSUME_NONNULL_END
