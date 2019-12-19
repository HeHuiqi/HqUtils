//
//  HqLineModel.h
//  GlobalPay
//
//  Created by hqmac on 2018/8/30.
//  Copyright © 2018年 solar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HqkLineModel.h"

@interface HqPointModel : NSObject

@property (nonatomic,assign) CGFloat xPosition;
@property (nonatomic,assign) CGFloat yPosition;

@property (nonatomic,assign) BOOL isFirst;
@property (nonatomic,assign) BOOL isLast;

@property(nonatomic,strong) HqkLineModel *kLinemodel;

@end
