
#import "Dialog.h"
#import "MBProgressHUD.h"
#import <unistd.h>

@implementation Dialog

static Dialog *instance = nil;

+ (Dialog *)Instance
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [self new];
        }
    }
    return instance;
}


+ (void)toast:(UIViewController *)controller withMessage:(NSString *)message {
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
	hud.mode = MBProgressHUDModeText;
	hud.label.text = message;
	hud.margin = 10.f;
    CGPoint currentOffset = hud.offset;
    currentOffset.y = -150.f;
    hud.offset = currentOffset;
	hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor]; 
	[hud hideAnimated:YES afterDelay:1];
}

+ (void)toast:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
	hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
	hud.label.text = message;
	hud.margin = 10.f;
    CGPoint currentOffset = hud.offset;
    currentOffset.y = -50.0;
    hud.offset = currentOffset;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
	hud.removeFromSuperViewOnHide = YES;
	[hud hideAnimated:YES afterDelay:1];
}

+ (void)simpleToast:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.label.text = message;
    hud.margin = 10.f;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    CGPoint currentOffset = hud.offset;
    currentOffset.y = 150.f;
    hud.offset = currentOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}


+ (void)toastCenter:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
	hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
	hud.label.text = message;
	hud.margin = 10.f;
    CGPoint currentOffset = hud.offset;
    currentOffset.y = -20.f;
    hud.offset = currentOffset;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
	hud.removeFromSuperViewOnHide = YES;
	[hud hideAnimated:YES afterDelay:1];
}

+ (void)progressToast:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
	hud.mode = MBProgressHUDModeIndeterminate;
	hud.label.text = message;
	hud.margin = 10.f;
    CGPoint currentOffset = hud.offset;
    currentOffset.y = -20.f;
    hud.offset = currentOffset;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
	hud.removeFromSuperViewOnHide = YES;
	[hud hideAnimated:YES afterDelay:1];
}



- (void)showProgress:(UIViewController *)controller {
    HUD = [[MBProgressHUD alloc] initWithView:controller.view];
    [controller.view addSubview:HUD];
//    HUD.dimBackground = YES;
    HUD.delegate = self;
     [HUD showAnimated:YES];
}

- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText {
    HUD = [[MBProgressHUD alloc] initWithView:controller.view];
    [controller.view addSubview:HUD];
    HUD.delegate = self;
//    HUD.dimBackground = YES;
    HUD.label.text = labelText;
     [HUD showAnimated:YES];
}

- (void)showCenterProgressWithLabel:(NSString *)labelText
{
    HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.delegate = self;
    //    HUD.dimBackground = YES;
    HUD.label.text = labelText;
     [HUD showAnimated:YES];
}

- (void)hideProgress {
    [HUD hideAnimated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	[HUD removeFromSuperview];
	HUD = nil;
}

@end
