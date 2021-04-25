//
//  HqRichTextUtil.h
//  HqUtils
//
//  Created by hehuiqi on 2021/2/26.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HqTextAttachment.h"
NS_ASSUME_NONNULL_BEGIN

@interface HqRichTextUtil : NSObject

+ (void)createAttributedStringWithHtml:(NSString *)html contentWidth:(CGFloat)contentWidth complete:(void(^)(NSMutableAttributedString *result))complete;

@end

NS_ASSUME_NONNULL_END
