//
//  HqMutilImagePickerVC.h
//  HqUtils
//
//  Created by hehuiqi on 7/23/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HqMutilImagePickerVCDelegate;
@interface HqMutilImagePickerVC : UIViewController

@property (nonatomic,weak) id<HqMutilImagePickerVCDelegate> delegate;

@property (nonatomic,assign) NSInteger maxSelectCount;


@end

@protocol HqMutilImagePickerVCDelegate <NSObject>

@optional
- (void)hMutilImagePickerVC:(HqMutilImagePickerVC *)vc didSelectedImages:(NSArray *)images;

@end

NS_ASSUME_NONNULL_END
