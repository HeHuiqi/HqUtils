//
//  HqkLineUtils.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/9.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HqklineShowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqkLineUtils : NSObject

+ (HqklineShowModel *)dealKlineDatas:(NSArray *)datas showViewHeight:(CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
