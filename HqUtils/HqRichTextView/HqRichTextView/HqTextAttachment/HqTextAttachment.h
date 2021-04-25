//
//  HqTextAttachment.h
//  HqRichTextEditorDemo
//
//  Created by hehuiqi on 2020/4/23.
//  Copyright © 2020 hehuiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqTextAttachment : NSTextAttachment<NSCoding>

@property(nonatomic,copy) NSString *localPath;
@property(nonatomic,copy) NSString *urlString;
@property(nonatomic,assign) NSRange range;


@end

NS_ASSUME_NONNULL_END
