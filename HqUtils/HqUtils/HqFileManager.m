//
//  FileManager.m
//  DaysDemo
//
//  Created by macpro on 15/10/22.
//  Copyright © 2015年 macpro. All rights reserved.
//

#import "HqFileManager.h"

@implementation HqFileManager

+ (NSFileManager *)HqFileManager
{
    NSFileManager *fileManager =[NSFileManager defaultManager];
    
    return fileManager;
}
+ (NSString *)getDocumentsDirectoy
{
    NSString *home = NSHomeDirectory();
    home = [home stringByAppendingPathComponent:@"Documents"];
    return home;
}
+ (NSString *)getPathWithFileName:(NSString *)fileName
{
    NSString *documents = [self getDocumentsDirectoy];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    return path;
}

//总磁盘大小
+ (float)getAllSpace
{
   
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    float allSpace=  [[fattributes objectForKey:NSFileSystemSize] floatValue];
    return allSpace;
}
//剩余空间
+ (float)getRestSapce
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
   
    float restSpace = [[fattributes objectForKey:NSFileSystemFreeSize] floatValue];
    return  restSpace;
}
@end
