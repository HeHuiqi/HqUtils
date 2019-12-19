//
//  HqklineShowModel.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/9.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HqPointModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HqklineShowModel : NSObject

@property(nonatomic,assign) CGFloat maxPrice;//某阶段最高价
@property(nonatomic,assign) CGFloat minPrice;//某阶段最低价

@property(nonatomic,strong) NSArray<HqPointModel *> *showPointArray;

@end

NS_ASSUME_NONNULL_END
