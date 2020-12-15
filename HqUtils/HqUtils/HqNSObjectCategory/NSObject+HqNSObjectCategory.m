//
//  NSObject+HqNSObjectCategory.m
//  HqUtils
//
//  Created by hehuiqi on 2020/2/13.
//  Copyright © 2020 hhq. All rights reserved.
//

#import "NSObject+HqNSObjectCategory.h"

#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (HqNSObjectCategory)


- (void)setAppPrePageName:(NSString *)appPrePageName{
    objc_setAssociatedObject(self, @"appPrePageName".UTF8String, appPrePageName, OBJC_ASSOCIATION_COPY);
}
- (NSString *)appPrePageName{
    return  objc_getAssociatedObject(self, @"appPrePageName".UTF8String);
}

- (void)setAppPrePageId:(NSString *)appPrePageId{
    objc_setAssociatedObject(self, @"appPrePageId".UTF8String, appPrePageId, OBJC_ASSOCIATION_COPY);
}
- (NSString *)appPrePageId{
    return  objc_getAssociatedObject(self, @"appPrePageId".UTF8String);
}


- (void)setAppPageName:(NSString *)appPageName{
    objc_setAssociatedObject(self, @"appPageName".UTF8String, appPageName, OBJC_ASSOCIATION_COPY);
}
- (NSString *)appPageName{
  return  objc_getAssociatedObject(self, @"appPageName".UTF8String);
}

- (void)setAppPageId:(NSString *)appPageId{
    objc_setAssociatedObject(self, @"appPageId".UTF8String, appPageId, OBJC_ASSOCIATION_COPY);
}
- (NSString *)appPageId{
  return  objc_getAssociatedObject(self, @"appPageId".UTF8String);

}




@end
