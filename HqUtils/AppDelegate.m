//
//  AppDelegate.m
//  HqUtils
//
//  Created by macpro on 2018/1/24.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "AppDelegate.h"
#import "HqAuthIDVC.h"
#import <dirent.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "HqEncrypt.h"
#import "HqUncaughtExceptionHandler.h"
#import "HqFPSLabel.h"
#import "HqNightModeVC/HqNightModeLayer.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [HqUncaughtExceptionHandler startCatchCrashWithShowException:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(crashReport:) name:HqUncaughtExceptionReportNofity object:nil];
//    [HqFPSLabel showFPSInView:nil];
    

   
    //延时一下等待window初始化完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL isOpen =  GetUserBoolDefault(kNightModeIsOpen);
        NSLog(@"isOpen:%@",@(isOpen));
        [HqNightModeLayer openNightMode:isOpen];
    });

    
    return YES;
}
- (void)crashReport:(NSNotification *)notify{
    NSLog(@"crash:%@",notify.object);
}

- (void)encryptParams{
        NSString *time =   [[HqDateFormatter shareInstance] getNowTimeTimestamp];

        NSString *json = [NSString stringWithFormat:@"{\"pageNum\":1,\"_timestamp\":%@}",time];
    //    json = @"{\"pageNum\":1,\"_timestamp\":1568884350000}";
        NSLog(@"json==%@",json);
        
        //正式
        NSString *key = @"eafd6e176461d663b45224251b7e42b5";
        NSString *iv = @"30b6d66bd30c5da3f447d0c9ac8020c2";
        
        //测试
    //    key = @"6fd2c45a86ab119ee3eddeaf8b79ee4f";
    //    iv = @"b3415628a345fcf68e1b32f74c6e7dc2";
        id resultData = nil;
        
        resultData = [HqEncrypt AES256EncryptWithKey:key iv:iv encryptText:json];
        NSLog(@"resultData==%@",[[NSString convertDataToHexStr:resultData] uppercaseString]);
    


    
}
- (NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

- (void)applicationWillEnterForeground:(UIApplication *)application{

}
//列出/dev目录下的所有文件，相当于ls命令
int myls(int argc, const char * argv[]) {
    @autoreleasepool {
        DIR *dp;
        struct dirent *dirp;

//        if (argc != 2)
//        {
//            printf("usage:ls directory_name\n");
//            return 0;
//        }
//        printf("argv[1]==%s\n", argv[1]);
        dp = opendir("/dev");
        int i = 0;
        if (dp != NULL){
//            printf("open %s\n",argv[1]);
            while ((dirp = readdir(dp)) != NULL){
                
                printf("%s\n", dirp->d_name);
                i++;
               

            }
        }
        if (dp) {
            closedir(dp);
        }
    }
    return 0;
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"-------applicationDidEnterBackground");
 

}




@end
