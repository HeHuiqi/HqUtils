//
//  HqFPSLabel.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/30.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HqWeakProxy : NSObject

@property(nonatomic,weak) id<NSObject> _Nullable target;

@end


NS_ASSUME_NONNULL_BEGIN

@interface HqFPSLabel : UILabel

@property(nonatomic,strong) CADisplayLink *link;
@property(nonatomic,assign) int count;
@property(nonatomic,assign) NSTimeInterval lastTime;
@property(nonatomic,strong) UIFont *qFont;
@property(nonatomic,strong) UIFont *subFont;
@property(nonatomic,assign) CGSize defaultSize;

+ (void)showFPSInView:(UIView * _Nullable)view;
@end


NS_ASSUME_NONNULL_END
