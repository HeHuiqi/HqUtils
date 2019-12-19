//
//  HqTradeTrendView.h
//  GlobalPay
//
//  Created by hqmac on 2018/8/30.
//  Copyright © 2018年 solar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqFoldLineView.h"
#import "HqYCoordinateView.h"

#import "HqklineShowModel.h"
@interface HqTradeTrendView : UIView

@property (nonatomic,strong) UILabel *startDateLab;
@property (nonatomic,strong) UILabel *endDateLab;

@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UISegmentedControl *segmentControl;
@property (nonatomic,strong) HqFoldLineView *foldLineView;
@property(nonatomic,strong) HqYCoordinateView *yCoordinateView;

@property (nonatomic,assign) CGFloat tradeMaxPrice;//某个时间段最高价
@property (nonatomic,assign) CGFloat tradeMinPrice;//某个时间段最底价
@property(nonatomic,strong) HqklineShowModel *klineShowModel;
@property (nonatomic,strong) NSArray *datas;


@end

