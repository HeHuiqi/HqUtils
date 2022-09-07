//
//  HqPaintFileManager.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqPaintFileManager.h"

@implementation HqPaintFileManager

+ (NSString *)fileDir{
    NSString *fielPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *file_dir = [NSString stringWithFormat:@"%@/my_paint_files",fielPath];
    return file_dir;
}

+ (BOOL)savePaint:(CAShapeLayer *)pintLayer{
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:pintLayer requiringSecureCoding:YES error:&error];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy_MM_dd_HH_mm_ss"];
    
    NSString *fileName = [df stringFromDate:NSDate.date];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *file_dir = HqPaintFileManager.fileDir;
    BOOL dir = YES;
    if (![fm fileExistsAtPath:file_dir isDirectory:&dir]) {
       BOOL suc =  [fm createDirectoryAtPath:file_dir withIntermediateDirectories:YES attributes:nil error:&error];
        NSLog(@"dir_create==%@",@(suc));
    }
    NSString *file = [NSString stringWithFormat:@"%@/%@",file_dir,fileName];
    NSLog(@"file==%@",file);
    BOOL suc = [data writeToFile:file atomically:YES];
    NSLog(@"suc==%@",@(suc));
    return suc;
}
+ (CAShapeLayer *)loadPaintFromFileName:(NSString *)fileName{
    NSError *error;
    NSString *file_dir = HqPaintFileManager.fileDir;
    NSString *file = [NSString stringWithFormat:@"%@/%@",file_dir,fileName];
    NSData *data = [[NSData alloc] initWithContentsOfFile:file];
    CAShapeLayer *layer =  [NSKeyedUnarchiver unarchivedObjectOfClass:CAShapeLayer.class fromData:data error:&error];
    return layer;
}

+ (NSArray *)allPaintFiles{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    NSString *file_dir = HqPaintFileManager.fileDir;
    NSArray *files = [fm contentsOfDirectoryAtPath:file_dir error:&error];
    return files;
}


@end
