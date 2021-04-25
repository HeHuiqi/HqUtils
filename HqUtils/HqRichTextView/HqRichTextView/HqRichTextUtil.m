//
//  HqRichTextUtil.m
//  HqUtils
//
//  Created by hehuiqi on 2021/2/26.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqRichTextUtil.h"

@implementation HqRichTextUtil


+ (void)createAttributedStringWithHtml:(NSString *)html contentWidth:(CGFloat)contentWidth complete:(void(^)(NSMutableAttributedString *result))complete{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *allSrc = [self htmlAllImgSrc:html];
        NSLog(@"allSrc=%@",allSrc);
        
        NSMutableArray *replaceAttachments = @[].mutableCopy;
        NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
        options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
        NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                      documentAttributes:nil error:nil];
        [attributeString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, attributeString.length) options:(NSAttributedStringEnumerationReverse) usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
            NSTextAttachment *attachment = value;
            if (attachment) {
                NSFileWrapper *fileWrapper = attachment.fileWrapper;
                //NSLog(@"attachment==%@",attachment);
                NSLog(@"range==%@",NSStringFromRange(range));

                NSLog(@"attachment.fileType==%@",attachment.fileType);
                NSLog(@"attachment.fileWrapper==%@",fileWrapper);
                NSLog(@"fileWrapper.filename==%@",fileWrapper.filename);
                NSLog(@"fileWrapper.preferredFilename==%@",fileWrapper.preferredFilename);
                NSLog(@"fileWrapper.fileAttributes==%@",fileWrapper.fileAttributes);
                UIImage *image = [UIImage imageWithData:fileWrapper.regularFileContents];
                if (fileWrapper.isSymbolicLink) {
                    NSLog(@"fileWrapper.symbolicLinkDestinationURL==%@",fileWrapper.symbolicLinkDestinationURL);
                }else{
                    NSLog(@"no symbolicLink");
                }
                NSLog(@"fileWrapper.serializedRepresentation==%@",image);
                HqTextAttachment *attachment = [[HqTextAttachment alloc] init];
                attachment.image = image;
                attachment.range = range;
                
                CGFloat width = contentWidth;
                CGFloat height = image.size.height;
                CGFloat imageScale = height/image.size.width;
                if (image.size.width>width) {
                    height = width *imageScale;
                }else{
                    width = image.size.width;
                }
                attachment.bounds = CGRectMake(0, 0, width, height);
                [allSrc enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj containsString:fileWrapper.preferredFilename]) {
                        attachment.urlString = obj;
                        [replaceAttachments addObject:attachment];
                        return;
                    }
                }];
            }
            
        }];
        
        for (HqTextAttachment *attachment in replaceAttachments) {
            NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attachment];
            [attributeString replaceCharactersInRange:attachment.range withAttributedString:attrStr];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(attributeString);
        });
    });

    
}

+ (NSArray *)htmlAllImgSrc:(NSString *)html{
    NSMutableArray *allSrc = @[].mutableCopy;
    NSString *content = html;
    NSString  *pattern = @"<img [^>]*src=['\"]([^'\"]+)[^>]*>";
    NSArray *imgTags = [self findString:content regexString:pattern];
    for (NSDictionary *imgeTagDic in imgTags) {
        NSString *imgeTag = [imgeTagDic objectForKey:@"match"];
        pattern = @"src=['\"]([^'\"]+)['\"]";
        NSDictionary *imageSrcDic = [self findString:imgeTag regexString:pattern].firstObject;
        NSString *matchSrc = [imageSrcDic objectForKey:@"match"];
        NSString *src = [matchSrc substringFromIndex:4];
        [allSrc addObject:src];
    }
    return allSrc;
}
+ (NSArray *)findString:(NSString *)string regexString:(NSString *)regexString{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    NSMutableArray *results = @[].mutableCopy;
    
    for (NSTextCheckingResult *result in matches) {
        NSString *rangeStr = NSStringFromRange(result.range);
        NSString *matchStr = [string substringWithRange:result.range];
        NSDictionary *dic = @{@"range":rangeStr,@"match":matchStr};
        [results addObject:dic];
    }
    NSLog(@"results==%@",results);
    return results;
}

@end
