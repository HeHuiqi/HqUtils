//
//  HqRefreshProtocol.h
//  HqPullRefresh
//
//  Created by hqmac on 2018/11/20.
//  Copyright © 2018 solar. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HqRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

//header
#define HqRefreshPullY 64
#define HqContentOffsetKeyPath @"contentOffset"
//footer
#define HqRefreshLoadingY 64


NS_ASSUME_NONNULL_BEGIN

@protocol HqRefreshProtocol <NSObject>

@end

NS_ASSUME_NONNULL_END
