//
//  HqMobile.h
//  HqUtils
//
//  Created by hehuiqi on 8/7/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

typedef void (* _IMP) (id _Nullable ,SEL _Nonnull ,...);


NS_ASSUME_NONNULL_BEGIN

@interface HqMobile : NSObject

- (void)call:(NSString *)number;

@end

NS_ASSUME_NONNULL_END
