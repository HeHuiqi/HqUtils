

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface Dialog : NSObject<MBProgressHUDDelegate> {
	MBProgressHUD *HUD;
    
	long long expectedLength;
	long long currentLength;
}

+ (Dialog *)Instance;

//类似于Android一个显示框效果
+ (void)toast:(UIViewController *)controller withMessage:(NSString *) message;
+ (void)toast:(NSString *)message;
+ (void)simpleToast:(NSString *)message;
//显示在屏幕中间
+ (void)toastCenter:(NSString *)message;
//带进度条
+ (void)progressToast:(NSString *)message;

//带遮罩效果的进度条

//显示遮罩
- (void)showProgress:(UIViewController *)controller;

//关闭遮罩
- (void)hideProgress;

//显示带说明的进度条
- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText;
- (void)showCenterProgressWithLabel:(NSString *)labelText;

@end
