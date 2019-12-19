//
//  HqFoldLineView.h
//  GlobalPay
//
//  Created by hqmac on 2018/8/30.
//  Copyright © 2018年 solar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqPointModel.h"

@protocol HqFoldLineViewDelegate;
@interface HqFoldLineView : UIView

@property(nonatomic,weak) id<HqFoldLineViewDelegate> delegate;
@property (nonatomic,assign) CGFloat tradeMaxPrice;//某个时间段最高价
@property (nonatomic,assign) CGFloat tradeMinPrice;//某个时间段最底价
@property (nonatomic,strong) NSArray *datas;


@end

@protocol HqFoldLineViewDelegate <NSObject>

@optional
- (void)hqFoldLineView:(HqFoldLineView *)view touchBeginShowPointModel:(HqPointModel *)model;
- (void)hqFoldLineViewTouchEndDismiss:(HqFoldLineView *)view;
@end
