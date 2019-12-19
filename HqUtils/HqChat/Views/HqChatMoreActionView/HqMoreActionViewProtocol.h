//
//  HqMoreActionViewProtocol.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/12.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HqMoreActionViewProtocol <NSObject>

@optional
- (void)morecActionClickItem:(HqListItemModel *)item;

@end

NS_ASSUME_NONNULL_END
