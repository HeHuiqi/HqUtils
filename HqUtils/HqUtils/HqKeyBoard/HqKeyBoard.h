//
//  HqKeyBoard.h
//  HqCustomKeyBorder
//
//  Created by macpro on 2018/2/8.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HqLineColor  [UIColor colorWithRed:192/255.0 green:193/255.0 blue:200/255.0 alpha:1.0]

#define HqNumberSize 17
#define HqBtnTitleColor [UIColor blackColor]

#define HqDoneBtnBgColor [UIColor colorWithRed:10.0/255.0 green:97.0/255.0 blue:254.0/255.0 alpha:1.0]
#define HqDoneBtnTitleColor [UIColor whiteColor]

@interface HqKeyBoard : UIView

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UITextField *tf;
@property (nonatomic,strong) UIImage *deleteImage;
@property (nonatomic,strong) UIImage *cancelImage;

@end
