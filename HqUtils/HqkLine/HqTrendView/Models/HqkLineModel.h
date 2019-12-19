//
//  HqkLineModel.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/9.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqkLineModel : NSObject

@property(nonatomic,copy) NSString *datetime;
@property(nonatomic,assign) NSTimeInterval timestamp;
@property(nonatomic,assign) CGFloat high;//最高价
@property(nonatomic,assign) CGFloat low;//最低价
@property(nonatomic,assign) CGFloat open;//开盘价
@property(nonatomic,assign) CGFloat close;//收盘价
@property(nonatomic,assign) CGFloat volumefrom;//总交易量
@property(nonatomic,assign) CGFloat volumeto;//总交易额


@end

NS_ASSUME_NONNULL_END
