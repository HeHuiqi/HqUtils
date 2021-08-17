//
//  HqUITextFiled.m
//  HqUtils
//
//  Created by hehuiqi on 2021/4/25.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqUITextField.h"

@implementation HqUITextField


- (void)setContentInsets:(UIEdgeInsets)contentInsets{
    _contentInsets = contentInsets;
    if (contentInsets.left > 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentInsets.left, self.bounds.size.height)];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
//    if (contentInsets.right > 0) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentInsets.right, self.bounds.size.height)];
//        self.rightView = view;
//        self.rightViewMode = UITextFieldViewModeAlways;
//    }
}


@end
