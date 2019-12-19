//
//  HqRichTextCell.h
//  HqUtils
//
//  Created by hehuiqi on 9/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqCellModel.h"


typedef void(^HqImageViweSizeChange) (void);

NS_ASSUME_NONNULL_BEGIN

@interface HqRichTextCell : UITableViewCell

@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIImageView *firstImageView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) HqCellModel *cellModel;

@property (nonatomic,assign) BOOL imageIsLoaded;

@property (nonatomic,copy) HqImageViweSizeChange imageViweSizeChange;


@end





NS_ASSUME_NONNULL_END
