//
//  HqLoopScrollItemView.h
//  HqUtils
//
//  Created by hehuiqi on 2020/1/21.
//  Copyright © 2020 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqLoopScrollItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqLoopScrollItemView : UIView

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *titleLab;

@property(nonatomic,strong) HqLoopScrollItem *scollItem;

@end

NS_ASSUME_NONNULL_END
