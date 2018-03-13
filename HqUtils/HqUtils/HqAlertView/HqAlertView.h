//
//  HqAlertView.h
//  QRCode
//
//  Created by macpro on 2018/1/25.
//  Copyright © 2018年 macpro. All rights reserved.
// 提示 UIAlertController iOS8.0以上支持

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^HqAlertCallBack)(UIAlertAction *action,int index);

@interface HqAlertView : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,strong) NSArray *btnTitles;
@property (nonatomic,strong) UIColor *cancelTextColor;
@property (nonatomic,strong) UIColor *normalTextColor;


@property (nonatomic,copy) HqAlertCallBack alertCallBack;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style;

- (UIAlertAction *)addBtnsWithTitle:(NSString *)title type:(UIAlertActionStyle)style;

- (void)showVC:(UIViewController *)vc callBack:(HqAlertCallBack)callBack;

@end


