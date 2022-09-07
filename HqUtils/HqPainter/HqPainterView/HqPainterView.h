//
//  HqPainterView.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/30.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqPainterToolBar.h"
#import "HqPath.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqPainterView : UIView

@property(nonatomic,strong) NSMutableArray *subPaths;
@property(nonatomic,strong) NSMutableArray *undoPaths;
@property(nonatomic,assign) NSInteger currentStep;
@property(nonatomic,strong) UIColor *strokeColor;
@property(nonatomic,assign) CGFloat lineWidth;

@property(nonatomic,strong) CAShapeLayer *showLayer;
@property(nonatomic,strong) NSMutableArray *removeLayers;
@property(nonatomic,assign) BOOL accrossLayerDraw;

@property(nonatomic,strong) HqPainterToolBar *toolBarView;

- (void)drawOptType:(NSInteger)optType;
- (void)refreshPaintboard;

@end

NS_ASSUME_NONNULL_END
