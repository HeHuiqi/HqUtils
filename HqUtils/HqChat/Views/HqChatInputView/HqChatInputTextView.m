//
//  HqChatInputTextView.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/13.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatInputTextView.h"

@implementation HqChatInputTextView


- (UIResponder *)nextResponder{
    if (self.hqNextResponder) {
        return self.hqNextResponder;
    }
    return [super nextResponder];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (self.hqNextResponder) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
