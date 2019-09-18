//
//  HqMutilImagePickerModel.h
//  HqUtils
//
//  Created by hehuiqi on 7/23/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqMutilImagePickerModel : NSObject

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,strong) PHAsset *phAsset;



@end

NS_ASSUME_NONNULL_END
