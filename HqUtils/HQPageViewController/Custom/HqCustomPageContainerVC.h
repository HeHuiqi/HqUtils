//
//  HqCustomPageContainerVC.h
//  HqUtils
//
//  Created by hehuiqi on 5/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPageContainerVC.h"
#import "HQPage1VC.h"
#import "HQPage2VC.h"
#import "HqPage3VC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqCustomPageContainerVC : HqPageContainerVC


@property(nonatomic,strong) HQPage1VC *pageV1;
@property(nonatomic,strong) HQPage2VC *pageV2;
@property(nonatomic,strong) HqPage3VC *pageV3;

@end

NS_ASSUME_NONNULL_END
