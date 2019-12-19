//
//  HqMoreActionItemView.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/12.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqMoreActionItemView : UIView

@property(nonatomic,strong) UIButton *actionBtn;
@property(nonatomic,strong) UILabel *actionInfoLab;

@property(nonatomic,strong) HqListItemModel *item;

@end

NS_ASSUME_NONNULL_END
