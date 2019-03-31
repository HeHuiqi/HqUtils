//
//  HqIconLab.m
//  GlobalPay
//
//  Created by hqmac on 2019/2/28.
//  Copyright © 2019 solar. All rights reserved.
//

#import "HqIconLab.h"

@implementation HqIconLab
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.leftRightSpace = 20;
        self.topBottomSpace = 10;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 16));
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGFloat )getTextWidthWithString:(NSString *)string fontSize:(CGFloat )size textHeight:(CGFloat)height
{
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil].size;
    return contentSize.width;
}
- (void)setText:(NSString *)text{
    [super setText:text];
    if (text.length>0) {
        
        CGFloat textWidth = [self getTextWidthWithString:text fontSize:self.font.pointSize textHeight:self.font.pointSize];
        CGFloat selfWidth = textWidth + self.leftRightSpace*2;
        CGFloat selfHeight = self.font.pointSize+self.topBottomSpace*2;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(selfWidth, selfHeight));
        }];
    }
}


@end
