//
//  HqTableView.m
//  HqUtils
//
//  Created by hehuiqi on 4/23/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTableView.h"

@implementation HqTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
