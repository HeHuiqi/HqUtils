//
//  HqProPainterView.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqPainterToolBar.h"
#import "HqPath.h"
#import "HqPaintFileManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqProPainterView : UIView


@property(nonatomic,assign) NSInteger currentStep;

@property(nonatomic,strong) UIColor *strokeColor;
@property(nonatomic,assign) CGFloat lineWidth;

@property(nonatomic,strong) CAShapeLayer *showLayer;

@property(nonatomic,strong,readonly) NSArray *addedLayers;
@property(nonatomic,strong) NSMutableArray *removeLayers;

@property(nonatomic,strong) HqPainterToolBar *toolBar;

- (BOOL)saveToFile;
- (void)loadAllPaints;
- (void)drawOptType:(NSInteger)optType;

- (void)loadLayers:(NSArray<CAShapeLayer *> *)layers;

@end

NS_ASSUME_NONNULL_END
