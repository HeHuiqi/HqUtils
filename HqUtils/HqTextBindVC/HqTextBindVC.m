//
//  HqTextBindVC.m
//  HqUtils
//
//  Created by hehuiqi on 9/28/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTextBindVC.h"
#import "HqTextView.h"

#import "SelectUserController.h"

@interface HqTextBindVC ()<UITextViewDelegate,HqTextViewDelegate>

@property(nonatomic,strong) HqTextView *textView;
@end

@implementation HqTextBindVC

- (HqTextView *)textView{
    if (!_textView) {
        _textView = [[HqTextView alloc] init];
        _textView.backgroundColor = HqLightGrayColor;
        _textView.font = SetFont(16);
        NSMutableAttributedString *atrs = [[NSMutableAttributedString alloc] initWithString:@"AACCAA"];
        [atrs addAttribute:NSLinkAttributeName value:@"https://www.baidu.com" range:NSMakeRange(2, 2)];
        _textView.attributedText = atrs;
        _textView.hqDelegate = self;
    }
    return _textView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    
    self.textView.frame = CGRectMake(15, 150, self.view.bounds.size.width-30, 200);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"@" style:UIBarButtonItemStyleDone target:self action:@selector(atClick)];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClick)];

    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1];
    
    

}
- (void)doneClick{
    [self converToPreviewFormat:self.textView.text];
}
- (void)converToPreviewFormat:(NSString *)text{
    /*
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
           NSString *link = @"https://user.profile.com?id=123";
           NSString *aTag = [NSString stringWithFormat:@"<a href='%@'>%@</a>",link,atStr];
           preview_str =  [preview_str stringByReplacingOccurrencesOfString:atStr withString:aTag];
       }
   }
    */
    [self.textView converToPreviewFormat:text];
    
//    NSLog(@"preview_str==%@",preview_str);
//type 1表示跳转到用户中心
//a标签链接格式 https://lichang.tag?id=123&type=1
    
    
}
- (void)atClick{
    
    SelectUserController *atVC= [[SelectUserController alloc] init];
    
    /*
    // 去选择@的人
     [self.textView unmarkText];
     NSInteger index = self.textView.text.length;

     if (self.textView.isFirstResponder)
     {
         index = self.textView.selectedRange.location + self.textView.selectedRange.length;
         [self.textView resignFirstResponder];
     }

     atVC.selectBlock = ^(NSString *name)
     {
         UITextView *textView = self.textView;

         NSString *insertString = [NSString stringWithFormat:kATFormat,name];
         NSMutableString *string = [NSMutableString stringWithString:textView.text];
         [string insertString:insertString atIndex:index];
         self.textView.text = string;

         [self.textView becomeFirstResponder];
         textView.selectedRange = NSMakeRange(index + insertString.length, 0);
         [self textViewDidChange:textView];
//         [self.textView inserAtStrRefresh];
     };
    */
    
    
    atVC.selectBlock = ^(NSString *name)
    {
        name = [self disable_EmojiString:name];
        NSString *atName = [NSString stringWithFormat:@"@%@ ",name];
        [self.textView.atInfos setValue:@"https://lichang.user?id=1&type=1" forKey:atName];
        [self.textView inserAtStr:name];
    };
    Push(atVC);
}

- (NSString*)disable_EmojiString:(NSString *)text
{
    //去除表情规则
    //  \u0020-\\u007E  标点符号，大小写字母，数字
    //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
    //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
    //  \uF900-\\uFAFF  部分汉字
    //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
    //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
    //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
    // 注：对照表 http://blog.csdn.net/hherima/article/details/9045765

    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];


    NSString* result = [expression stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, text.length) withTemplate:@""];

    return result;
}
#pragma mark HqTextViewDelegate

- (void)hqTextViewDidInputAt:(HqTextView *)textView{
    [self atClick];
}
#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"vooo==");


}

/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"@"]) {
//        [self atClick];
//        return NO;
//    }
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
                [string replaceCharactersInRange:match.range withString:@""];
                
                break;
            }
        }
        
        if (inAt)
        {
            textView.text = string;
            textView.selectedRange = NSMakeRange(index, 0);
            [self textViewDidChange:textView];
            return NO;
        }
    }
    return YES;
}

- (NSArray<NSTextCheckingResult *> *)findAllAt
{
    // 找到文本中所有的@
    NSString *string = self.textView.text;
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
         
         NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:textView.text];
         [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, string.string.length)];
         
         NSArray *matches = [self findAllAt];
         
         for (NSTextCheckingResult *match in matches)
         {
             NSRange matchRange = NSMakeRange(match.range.location, match.range.length - 1);
//             NSString *matchStr = [textView.text substringWithRange:matchRange];
             [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:matchRange];
         }
         
         textView.attributedText = string;
         textView.selectedRange = range;
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
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
