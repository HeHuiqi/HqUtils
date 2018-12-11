//
//  NSObject+HqInputLimit.m
//  GlobalPay
//
//  Created by hqmac on 2018/8/7.
//  Copyright © 2018年 solar. All rights reserved.
//

#import "NSObject+HqInputLimit.h"

#import <objc/runtime.h>
#import <objc/message.h>

// key 要初始化
void * kHqInputMaxLengthkey = "kHqInputMaxLengthkey";

@implementation NSObject (HqInputLimit)

- (void)setHqMaxLength:(NSUInteger)hqMaxLength{
    objc_setAssociatedObject(self, kHqInputMaxLengthkey, @(hqMaxLength).copy, OBJC_ASSOCIATION_ASSIGN);
}
- (NSUInteger)hqMaxLength{
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, kHqInputMaxLengthkey);
    //    NSLog(@"number == %@",number);
    return [number integerValue];
}
- (void)hqTextDidChangeNotifi:(NSNotification *)notif{
    id inputView = notif.object;
    if ([inputView isKindOfClass:UITextField.class]) {
        UITextField *tf = (UITextField *)inputView;
        [self hqTextFieldDidChange:tf];
        return;
    }
    if ([inputView isKindOfClass:UITextView.class]) {
        UITextView *tv  = (UITextView *)inputView;
        [self hqTextViewDidChange:tv];
        return;
    }
}


- (void)hqTextFieldDidChange:(UITextField *)textField{
    NSUInteger maxLength = self.hqMaxLength;
    
    NSString *toBeString = textField.text;
    UITextInputMode *inputMode = textField.textInputMode;
    if (maxLength>0) {
        NSString *lang = [inputMode primaryLanguage]; // 键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textField markedTextRange];       //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > maxLength) {
                    textField.text = [toBeString substringToIndex:maxLength];
                }
            }       // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
                
            }
        }else{
            // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (toBeString.length > maxLength) {
                textField.text = [toBeString substringToIndex:maxLength];
            }
        }
    }
    
    
}
- (void)hqTextViewDidChange:(UITextView *)textView{
    NSUInteger maxLength = self.hqMaxLength;
    
    NSString *toBeString = textView.text;
    UITextInputMode *inputMode = textView.textInputMode;
    if (maxLength>0) {
        NSString *lang = [inputMode primaryLanguage]; // 键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textView markedTextRange];       //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > maxLength) {
                    textView.text = [toBeString substringToIndex:maxLength];
                }
            }       // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{

            }
        }else{
            // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (toBeString.length > maxLength) {
                textView.text = [toBeString substringToIndex:maxLength];
            }
        }
    }
}

@end
