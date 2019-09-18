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


    
    return YES;
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
//    NSLog(@"-------applicationDidEnterBackground");

}
@end
