//
//  HqCornerCell.h
//  HqUtils
//
//  Created by hehuiqi on 2021/4/23.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HqCornetPosition) {
    HqCornetPositionAll,
    HqCornetPositionTop,
    HqCornetPositionBottom,
    HqCornetPositionCenter,
};

NS_ASSUME_NONNULL_BEGIN

@interface HqCornerCell : UITableViewCell

@property(nonatomic,strong) CAShapeLayer *bgLayer;
@property(nonatomic,strong) CAShapeLayer *shadowLayer;

@property(nonatomic,assign) CGFloat bgLayerBorderWidth;
@property(nonatomic,assign) HqCornetPosition cornetPosition;

@end

NS_ASSUME_NONNULL_END
