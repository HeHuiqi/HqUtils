//
//  HqCategoryItem.m
//  HqUtils
//
//  Created by hehuiqi on 2021/3/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqCategoryItem.h"

@implementation HqCategoryItem

- (UIColor *)normalColor{
    if (_normalColor == nil) {
        return HqLightGrayColor;
    }
    return _normalColor;
}
- (UIColor *)selectedColor{
    if (_selectedColor == nil) {
        return [UIColor blackColor];
    }
    return _selectedColor;
}

@end
