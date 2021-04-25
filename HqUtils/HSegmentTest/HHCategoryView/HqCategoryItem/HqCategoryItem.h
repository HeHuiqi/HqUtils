//
//  HqCategoryItem.h
//  HqUtils
//
//  Created by hehuiqi on 2021/3/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqCategoryItem : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) UIColor *normalColor;
@property(nonatomic,strong) UIColor *selectedColor;

@property(nonatomic,assign) BOOL isZoom;

@property(nonatomic,assign) CGFloat cellWidth;
@property(nonatomic,assign) CGRect cellFrame;

@property(nonatomic,assign) BOOL showArrow;

@property(nonatomic,assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
