//
//  FileManager.h
//  DaysDemo
//
//  Created by macpro on 15/10/22.
//  Copyright © 2015年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqFileManager : NSObject

+ (NSString *)getDocumentsDirectoy;

+ (NSString *)getPathWithFileName:(NSString *)fileName;

//总磁盘大小
+ (float)getAllSpace;

//剩余空间
+ (float)getRestSapce;

@end
