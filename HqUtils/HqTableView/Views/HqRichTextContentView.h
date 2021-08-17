//
//  HqRichTextContentView.h
//  HqUtils
//
//  Created by hehuiqi on 2021/4/30.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqRichTextContentView : UIView

@property(nonatomic,assign) CGSize imageSize;


@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIImageView *firstImageView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) HqCellModel *cellModel;

@end

NS_ASSUME_NONNULL_END
