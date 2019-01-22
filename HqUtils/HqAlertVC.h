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

- (void)showWithVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
