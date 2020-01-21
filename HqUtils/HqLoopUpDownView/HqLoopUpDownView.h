//
//  HqLoopUpDownView.h
//  HqUtils
//
//  Created by hehuiqi on 2020/1/8.
//  Copyright © 2020 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqLoopUpDownItemView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HqLoopUpDownViewDelegate;
@interface HqLoopUpDownView : UIView

@property(nonatomic,weak) id<HqLoopUpDownViewDelegate> delegate;
@property(nonatomic,strong,nullable) NSTimer *loopTimer;
@property(nonatomic,assign) NSInteger loopIndex;
@property(nonatomic,strong) HqLoopUpDownItemView *showItemView;
@property(nonatomic,strong) HqLoopUpDownItemView *hideItemView;

@property(nonatomic,strong) NSArray *items;

- (void)startLoop;
- (void)loopIndex:(NSInteger)index;

@end

@protocol HqLoopUpDownViewDelegate <NSObject>

@optional
- (void)hqLoopUpDownView:(HqLoopUpDownView *)view clickItem:(HqLoopUpDownItem *)item;

@end

NS_ASSUME_NONNULL_END
