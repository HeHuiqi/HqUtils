//
//  HqRefreshHeader.h
//  HqPullRefresh
//
//  Created by hqmac on 2018/11/19.
//  Copyright © 2018 solar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqRefreshProtocol.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^HqBeginRefreshBlock)(void);
@interface HqRefreshHeader : UIView

@property (nonatomic,strong) CAShapeLayer *pathLayer;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) CGFloat pullScale;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,strong) UIActivityIndicatorView *indictatorView;
@property (nonatomic,copy) HqBeginRefreshBlock beginRefreshBlock;
@property (nonatomic,strong) UIColor *refreshColor;

- (void)beginRefreshingWithBlock:(HqBeginRefreshBlock)block;
- (void)endRefreshing;
@end

NS_ASSUME_NONNULL_END
