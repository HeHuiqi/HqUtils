//
//  HqRichTextView.h
//  HqRichTextEditorDemo
//
//  Created by hehuiqi on 2020/4/24.
//  Copyright © 2020 hehuiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqTextAttachment.h"
#import "HqRichTextUtil.h"
NS_ASSUME_NONNULL_BEGIN

@interface HqRichTextView : UITextView

@property(nonatomic,copy) NSString *fileName;
@property(nonatomic,copy,readonly) NSString *saveFilePath;
@property(nonatomic,assign) CGFloat toolBarHeight;

- (void)insertImage:(UIImage *)image  localPath:(NSString * _Nullable)localPath urlString:(NSString * _Nullable)urlString;

- (void)loadSaveCotent:(id)saveContent;
- (void)loadHtml:(NSString *)html;
- (NSString *)exportHtml;

@end

NS_ASSUME_NONNULL_END
