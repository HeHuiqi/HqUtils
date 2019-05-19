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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self UTCDateStr:@"2019-04-19T02:33:04.000Z" convertFormat:@"yyyy-MM-dd"];
    

   

    return YES;
}
//dateStr为这种格式 2019-04-19T02:38:41.000Z
- (NSString *)UTCDateStr:(NSString *)dateStr convertFormat:(NSString *)format{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *date = [df dateFromString:dateStr];
    NSTimeInterval interval = [timeZone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
    NSLog(@"date----%@",date);

    [df setDateFormat:format];

    NSString *result = [df stringFromDate:date];
    NSLog(@"result----%@",result);
    return result;
}


- (void)applicationWillEnterForeground:(UIApplication *)application{
//    NSLog(@"-------applicationWillEnterForeground");
//    HqAuthIDVC *auth = [HqAuthIDVC new];
//    [auth authVerification];

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
//    NSLog(@"-------applicationDidEnterBackground");

}
@end
