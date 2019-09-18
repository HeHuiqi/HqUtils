//
//  HqRandomBtnView.h
//  HqUtils
//
//  Created by hehuiqi on 8/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqRandomBtn.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HqRandomBadgeViewDelegate;
@interface HqRandomBadgeView : UIView

@property (nonatomic,weak) id<HqRandomBadgeViewDelegate> delegate;
@property (nonatomic,strong) UIImage *badgeImage;

@property (nonatomic,strong) NSMutableArray<HqRandomModel *> *datas;


@end


@protocol HqRandomBadgeViewDelegate <NSObject>

@optional
- (void)randomBadgeView:(HqRandomBadgeView *)view didSelectedModel:(HqRandomModel *)model;
- (void)randomBadgeViewDeleteAllWithView:(HqRandomBadgeView *)view;

- (void)randomBadgeView:(HqRandomBadgeView *)view deleteAllModel:(HqRandomModel *)model;


@end

NS_ASSUME_NONNULL_END
