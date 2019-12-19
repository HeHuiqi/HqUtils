//
//  HqTextView.m
//  HqUtils
//
//  Created by hehuiqi on 9/28/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTextView.h"

@interface HqTextView ()

@end

@implementation HqTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.atInfos = [[NSMutableDictionary alloc] init];

        self.delegate = self;
    }
    return self;
}

- (NSString *)converToPreviewFormat:(NSString *)text atKeyValues:(NSDictionary *)atKeyValues{
    
    NSString *orignal_text = text;
    NSString *preview_str = orignal_text.copy;

    NSArray *matches = [self findAllAt];
    NSMutableArray *atmathes_strs = [[NSMutableArray alloc] init];
           
    for (NSTextCheckingResult *match in matches){
        NSString *atStr = [orignal_text substringWithRange:match.range];
        [atmathes_strs addObject:atStr];
    }
   for (NSString *atStr in  atmathes_strs)
   {
       if (atStr) {
           NSLog(@"atStr==%@",atStr);
           
           NSString *link = atKeyValues[atStr];
           if (link.length>0) {
               NSString *aTag = [NSString stringWithFormat:@"<a href='%@'>%@</a>",link,atStr];
               preview_str =  [preview_str stringByReplacingOccurrencesOfString:atStr withString:aTag];
           }
       }
   }
    NSLog(@"preview_str==%@",preview_str);
//type 1表示跳转到用户中心
//a标签链接格式 https://lichang.tag?id=123&type=1
    return preview_str;
    
}
- (NSString *)converToPreviewFormat:(NSString *)text{
    
    NSLog(@"self.atInfos==%@",self.atInfos);
    NSString *orignal_text = text;
    NSString *preview_str = orignal_text.copy;

    NSArray *matches = [self findAllAt];
    NSMutableArray *atmathes_strs = [[NSMutableArray alloc] init];
           
    for (NSTextCheckingResult *match in matches){
        NSString *atStr = [orignal_text substringWithRange:match.range];
        [atmathes_strs addObject:atStr];
    }
   for (NSString *atStr in  atmathes_strs)
   {
       if (atStr) {
           NSLog(@"atStr==%@",atStr);
           NSString *link = self.atInfos[atStr];
           if (link) {
               NSString *aTag = [NSString stringWithFormat:@"<a href='%@'>%@</a>",link,atStr];
               preview_str =  [preview_str stringByReplacingOccurrencesOfString:atStr withString:aTag];
           }
       }
   }
    NSLog(@"preview_str==%@",preview_str);
//type 1表示跳转到用户中心
//a标签链接格式 https://lichang.tag?id=123&type=1
    return preview_str;
    
}
- (void)inserAtStrRefresh{
    [self textViewDidChange:self];
}
- (void)inserAtStr:(NSString *)atStr{
    if (atStr) {
        // 去选择@的人
         [self unmarkText];
         NSInteger index = self.text.length;

         if (self.isFirstResponder)
         {
             index = self.selectedRange.location + self.selectedRange.length;
             [self resignFirstResponder];
         }
        NSString *insertString = [NSString stringWithFormat:kATFormat,atStr];
        NSMutableString *string = [NSMutableString stringWithString:self.text];
        [string insertString:insertString atIndex:index];
        self.text = string;

        [self becomeFirstResponder];
        self.selectedRange = NSMakeRange(index + insertString.length, 0);
        [self textViewDidChange:self];
    }
}
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"@"]) {
        if ([self.hqDelegate respondsToSelector:@selector(hqTextViewDidInputAt:)] && self.hqDelegate) {
            [self.hqDelegate hqTextViewDidInputAt:self];
        }
        return NO;
    }
    if ([text isEqualToString:@""])
    {
        NSRange selectRange = textView.selectedRange;
        if (selectRange.length > 0)
        {
            //用户长按选择文本时不处理
            return YES;
        }
        
        // 判断删除的是一个@中间的字符就整体删除
        NSMutableString *string = [NSMutableString stringWithString:textView.text];
        NSArray *matches = [self findAllAt];
        
        BOOL inAt = NO;
        NSInteger index = range.location;
        for (NSTextCheckingResult *match in matches)
        {
            NSRange newRange = NSMakeRange(match.range.location + 1, match.range.length - 1);
            if (NSLocationInRange(range.location, newRange))
            {
                inAt = YES;
                index = match.range.location;
                NSString *delete_atStr = [string substringWithRange:match.range];
                NSLog(@"delete_atStr==%@",delete_atStr);
                if (self.atInfos) {
                    [self.atInfos removeObjectForKey:delete_atStr];
                }
                [string replaceCharactersInRange:match.range withString:@""];
                break;
            }
        }
        
        if (inAt)
        {
            textView.text = string;
            textView.selectedRange = NSMakeRange(index, 0);
            [self textViewDidChange:self];
            return NO;
        }
    }
    return YES;
}

- (NSArray<NSTextCheckingResult *> *)findAllAt
{
    // 找到文本中所有的@
    NSString *string = self.text;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kATRegular options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [regex matchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, [string length])];
    return matches;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    UITextRange *selectedRange = textView.markedTextRange;
     NSString *newText = [textView textInRange:selectedRange];
     if (newText.length < 1)
     {
         // 高亮输入框中的@
         NSRange range = textView.selectedRange;
         NSInteger textlength = textView.text.length;
         NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:textView.text];
         [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textlength)];
         [string addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textlength)];
         
         NSArray *matches = [self findAllAt];

         for (NSTextCheckingResult *match in matches)
         {
             NSRange matchRange = NSMakeRange(match.range.location, match.range.length - 1);

             [string addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:matchRange];
         }
//         NSLog(@"string==%@",string);
         textView.attributedText = string;
         textView.selectedRange = range;
     }
    if ([self.hqDelegate respondsToSelector:@selector(hqTextViewDidChange:)] && self.hqDelegate) {
        [self.hqDelegate hqTextViewDidChange:self];
    }
}
- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    // 光标不能点落在@词中间
    NSRange range = textView.selectedRange;
    if (range.length > 0)
    {
        // 选择文本时可以
        return;
    }
    NSArray *matches = [self findAllAt];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange newRange = NSMakeRange(match.range.location + 1, match.range.length - 1);
        if (NSLocationInRange(range.location, newRange))
        {
            textView.selectedRange = NSMakeRange(match.range.location + match.range.length, 0);
            break;
        }
    }
}
@end
