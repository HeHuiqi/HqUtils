//
//  NSObject+HqNSObjectCategory.h
//  HqUtils
//
//  Created by hehuiqi on 2020/2/13.
//  Copyright © 2020 hhq. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HqNSObjectCategory)

@property(nonatomic,copy) NSString *appPrePageName;
@property(nonatomic,copy) NSString *appPrePageId;

@property(nonatomic,copy) NSString *appPageName;
@property(nonatomic,copy) NSString *appPageId;


@end

NS_ASSUME_NONNULL_END
