//
//  HqLoopScrollVIew.h
//  HqUtils
//
//  Created by hehuiqi on 2020/1/21.
//  Copyright © 2020 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqLoopScrollItemView.h"
#import "HqTimer.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqLoopScrollVIew : UIView


@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,assign) NSInteger currentIndex;

@property(nonatomic,strong) HqLoopScrollItemView *lastView;
@property(nonatomic,strong) HqLoopScrollItemView *currentView;
@property(nonatomic,strong) HqLoopScrollItemView *nextView;

@property(nonatomic,assign) NSTimeInterval timeInterval;
//@property(nonatomic,weak) HqTimer *loopTimer;
@property(nonatomic,weak) NSTimer *loopTimer;



@property(nonatomic,assign) BOOL loop;

@property(nonatomic,strong) NSArray *datas;


- (void)testData;
@end

NS_ASSUME_NONNULL_END
