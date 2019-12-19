//
//  HqMoreActionViewCell.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/12.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HqMoreActionViewCellId @"HqMoreActionViewCell"
#import "HqMoreActionItemView.h"

#import "HqMoreActionViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface HqMoreActionViewCell : UICollectionViewCell

@property(nonatomic,weak)  id<HqMoreActionViewProtocol> delegate;
@property(nonatomic,strong) UIButton *actionBtn;
@property(nonatomic,strong) UILabel *actionInfoLab;

@property(nonatomic,strong) NSArray *items;

@end

NS_ASSUME_NONNULL_END
