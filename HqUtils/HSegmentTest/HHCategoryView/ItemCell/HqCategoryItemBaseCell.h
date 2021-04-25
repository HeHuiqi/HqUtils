//
//  HqCategoryItemBaseCell.h
//  HqUtils
//
//  Created by hehuiqi on 2021/3/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HqCategoryItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqCategoryItemBaseCell : UICollectionViewCell

@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) HqCategoryItem *item;
@property(nonatomic,strong) UIImageView *downArrowIcon;
@property(nonatomic,assign) BOOL downArrowIsUp;

- (void)setup;

- (void)hqLayoutSuviews;
@end

NS_ASSUME_NONNULL_END
