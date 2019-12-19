//
//  HqNineBoxView.h
//  LC
//
//  Created by hehuiqi on 2019/11/19.
//  Copyright © 2019 youfu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqNineBoxView : UIView

@property(nonatomic,strong) NSArray *imageDatas;
@property(nonatomic,assign) CGFloat boxHeight;
@property(nonatomic,assign) CGFloat boxItemHeight;
@property(nonatomic,assign) CGFloat boxItemSpace;

@end

NS_ASSUME_NONNULL_END
