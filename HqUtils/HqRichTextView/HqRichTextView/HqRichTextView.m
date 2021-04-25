//
//  HqRichTextView.m
//  HqRichTextEditorDemo
//
//  Created by hehuiqi on 2020/4/24.
//  Copyright © 2020 hehuiqi. All rights reserved.
//

#import "HqRichTextView.h"

@interface HqRichTextView ()<NSTextAttachmentContainer>

@end

@implementation HqRichTextView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setup{
    self.font = [UIFont systemFontOfSize:15];
    [self addObserverKeyboardChange];
}
- (void)addObserverKeyboardChange{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowHideNotify:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowHideNotify:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)keyboardShowHideNotify:(NSNotification *)notify{
    CGRect keyboardFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(keyboardFrame);
//    NSLog(@"keyboardHeight==%@",@(keyboardHeight));
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {
        [UIView animateWithDuration:0.3 animations:^{
            UIEdgeInsets insets = self.contentInset;
            CGFloat maxH = CGRectGetMaxY(self.frame);
            CGFloat restH = SCREEN_HEIGHT - maxH;
            if (restH < keyboardHeight ) {
//                insets.bottom = keyboardHeight - self.toolBarHeight;
                insets.bottom = (keyboardHeight - restH) + 20 + self.toolBarHeight;
            }
            self.contentInset = insets;
        } completion:^(BOOL finished) {
            
        }];

    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIEdgeInsets insets = self.contentInset;
            insets.bottom = 0;
            self.contentInset = insets;
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    NSLog(@"position==%@",NSStringFromCGPoint(position));
    return CGRectZero;
}
- (void)insertImage:(UIImage *)image  localPath:(NSString * _Nullable)localPath urlString:(NSString * _Nullable)urlString{
    
    NSMutableAttributedString *myAtrs = self.attributedText.mutableCopy;
    
    [self.textStorage endEditing];
    
    HqTextAttachment *imageAttachment = [[HqTextAttachment alloc] init];
    CGFloat width = self.bounds.size.width-self.textContainer.lineFragmentPadding*2;
    CGFloat height = image.size.height;
    CGFloat imageScale = height/image.size.width;
    if (image.size.width>width) {
        height = width *imageScale;
    }else{
        width = image.size.width;
    }
    imageAttachment.bounds = CGRectMake(0, 0, width, height);
    imageAttachment.image = image;
//    imageAttachment.image = [UIImage new];

    imageAttachment.localPath = localPath;
    imageAttachment.urlString = urlString;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.bounds  = CGRectMake(0, 0, width, height);
    imageView.image = image;
//    [self addSubview:imageView];
//    NSAttributedString *space = [[NSAttributedString alloc] initWithString:@"\n" attributes:@{NSFontAttributeName:self.font}];
    NSMutableAttributedString *insertArtrs = [[NSMutableAttributedString alloc] init];
    NSAttributedString *imageAtrs = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    [insertArtrs appendAttributedString:imageAtrs];
    [insertArtrs addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, insertArtrs.length)];
//    [insertArtrs appendAttributedString:space];
    
    
    [myAtrs insertAttributedString:insertArtrs atIndex:self.selectedRange.location];
    
    [self.textStorage endEditing];
    self.selectedRange = NSMakeRange(self.selectedRange.length, 1);
    
    self.attributedText = myAtrs;
}
- (void)loadSaveCotent:(id)saveContent{
    NSMutableAttributedString *myAtrs = (NSMutableAttributedString *)saveContent;
    self.attributedText = myAtrs;
}
- (void)loadHtml:(NSString *)html{
    CGFloat width = self.bounds.size.width-self.textContainer.lineFragmentPadding*2;
    if (width<=0) {
        width = [UIScreen mainScreen].bounds.size.width - 10;
    }
    [HqRichTextUtil createAttributedStringWithHtml:html contentWidth:width complete:^(NSMutableAttributedString * _Nonnull result) {
        NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithAttributedString:result];
        [atr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, atr.length)];
        NSLog(@"atr==%@",atr);
        self.attributedText = atr;
    }];
    
}
- (NSString *)exportHtml{
    NSAttributedString *myAtrs = self.attributedText;
    NSString *text = myAtrs.string;
    if (text.length==0) {
        return nil;
    }
    NSMutableString *html = [[NSMutableString alloc] initWithString:@"<p>"];
    [myAtrs enumerateAttributesInRange:NSMakeRange(0, myAtrs.length) options:(NSAttributedStringEnumerationLongestEffectiveRangeNotRequired) usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        HqTextAttachment *attachment = (HqTextAttachment *) attrs[NSAttachmentAttributeName];
        if (attachment) {
            NSLog(@"attachment.image==%@",attachment.image);
            NSLog(@"attachment.localPath==%@",attachment.localPath);
            NSLog(@"attachment.urlString2==%@",attachment.urlString);
            NSString *img = [NSString stringWithFormat:@"<img src='%@' style='widht:100%%'/>",attachment.urlString];
            [html appendString:img];
        }
        NSString *selectString = [text substringWithRange:range];
        if ([selectString isEqualToString:@"\n"]) {
            [html appendString:@"<br/>"];
        }
        
        [html appendString:selectString];
        
        
    }];
    [html appendString:@"</p>"];
    return html;
}



@end
