//
//  HqRefreshFooter.h
//  HqPullRefresh
//
//  Created by hqmac on 2018/11/20.
//  Copyright © 2018 solar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqRefreshProtocol.h"

typedef void(^HqBeginLoadingBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface HqRefreshFooter : UIView
@property (nonatomic,strong) CAShapeLayer *pathLayer;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) CGFloat pullScale;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,strong) UIActivityIndicatorView *indictatorView;
@property (nonatomic,copy) HqBeginLoadingBlock beginLoadingBlock;
@property (nonatomic,strong) UIColor *refreshColor;

- (void)beginRefreshing;
- (void)beginRefreshingWithBlock:(HqBeginLoadingBlock)block;
- (void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
