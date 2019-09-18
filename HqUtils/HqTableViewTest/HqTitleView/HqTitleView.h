//
//  HqTitleView.h
//  HqTabTest
//
//  Created by hehuiqi on 8/17/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqTitleView : UIView

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIImageView *userIcon;


@property (nonatomic,assign) CGFloat changeHeight;

@property (nonatomic,strong) UIScrollView *scollView;


@end

NS_ASSUME_NONNULL_END
