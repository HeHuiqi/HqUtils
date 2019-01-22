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
    [self applicationWillEnterForeground:application];
//    myls(0, NULL);
  


    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    NSLog(@"-------applicationWillEnterForeground");
    HqAuthIDVC *auth = [HqAuthIDVC new];
    [auth authVerification];

}
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
   
      
        printf("Hello, World!\n");
    }
    return 0;
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"-------applicationDidEnterBackground");

}
@end
