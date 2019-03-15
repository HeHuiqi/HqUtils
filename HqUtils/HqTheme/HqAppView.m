//
//  HqAppView.m
//  HqUtils
//
//  Created by hqmac on 2019/3/14.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "HqAppView.h"

@implementation HqAppView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)tintColorDidChange{
    
    if (self.tintColor == [UIColor redColor]) {
        NSLog(@"tintColorDidChange");
    }
    self.backgroundColor = self.tintColor;

}
@end
