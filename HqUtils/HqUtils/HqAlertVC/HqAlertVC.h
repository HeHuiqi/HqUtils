//
//  HqAlertVC.h
//  HqUtils
//
//  Created by hqmac on 2019/1/18.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "SuperVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqAlertVC : UIViewController

@property (nonatomic,assign) CGFloat contentHeight;
@property (nonatomic,strong) UIView *contentView;

- (void)showWithVC:(UIViewController *)vc;
- (void)hqLayoutSubViews;
@end

NS_ASSUME_NONNULL_END
