//
//  HqListItemModel.m
//  GlobalPay
//
//  Created by hqmac on 2019/3/5.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqListItemModel.h"

@implementation HqListItemModel

+ (HqListItemModel *)item{
    HqListItemModel *it =  [[HqListItemModel alloc] init];
    it.hq_value = @"";
    return it;
}

@end
