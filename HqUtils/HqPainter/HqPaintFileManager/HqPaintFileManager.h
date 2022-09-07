//
//  HqPaintFileManager.h
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqPaintFileManager : NSObject

@property(class,nonatomic,copy,readonly) NSString *fileDir;
+ (CAShapeLayer *)loadPaintFromFileName:(NSString *)fileName;
+ (BOOL)savePaint:(CAShapeLayer *)pintLayer;
+ (NSArray *)allPaintFiles;
@end

NS_ASSUME_NONNULL_END
