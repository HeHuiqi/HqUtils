//
//  HqPickerImageCell.h
//  HqUtils
//
//  Created by hehuiqi on 7/23/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqMutilImagePickerModel.h"

#define HqPickerImageCellID @"HqPickerImageCell"

NS_ASSUME_NONNULL_BEGIN

@interface HqPickerImageCell : UICollectionViewCell


@property (nonatomic,strong) HqMutilImagePickerModel *pickerModel;


@property (nonatomic,strong) UIImageView *checkImageView;

@property (nonatomic,strong) UIImageView *showImageView;


@end

NS_ASSUME_NONNULL_END
