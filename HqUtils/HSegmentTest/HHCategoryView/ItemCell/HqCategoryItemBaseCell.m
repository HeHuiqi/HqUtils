//
//  HqCategoryItemBaseCell.m
//  HqUtils
//
//  Created by hehuiqi on 2021/3/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqCategoryItemBaseCell.h"

@implementation HqCategoryItemBaseCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:kZoomValue(15)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UIImageView *)downArrowIcon{
    if (!_downArrowIcon) {
        _downArrowIcon = [[UIImageView alloc] init];
        _downArrowIcon.image = [UIImage imageNamed:@"down_arrow_icon"];
    }
    return _downArrowIcon;
}
- (void)setup{
    [self addSubview:self.titleLab];
}
- (void)hqLayoutSuviews{
    
}
- (void)setDownArrowIsUp:(BOOL)downArrowIsUp{
    _downArrowIsUp = downArrowIsUp;
    CGAffineTransform defaultTransfrom = CGAffineTransformIdentity;
    CGAffineTransform upTransfrom = CGAffineTransformRotate(defaultTransfrom, M_PI);
    self.downArrowIcon.transform = downArrowIsUp ? upTransfrom:defaultTransfrom;
}
- (void)setItem:(HqCategoryItem *)item{
    _item = item;
    if (item) {
        self.titleLab.text = item.title;
        UIColor *textColor = item.selected ? item.selectedColor:item.normalColor;
        CGAffineTransform defaultTransfrom = CGAffineTransformIdentity;
        CGAffineTransform zoomTransfrom = CGAffineTransformScale(defaultTransfrom, 1.2, 1.2);
//        [UIView animateWithDuration:0.3 animations:^{
//            self.titleLab.transform = item.isZoom ? zoomTransfrom:defaultTransfrom;
//        }];
        self.downArrowIsUp = NO;
        self.downArrowIcon.hidden = !item.showArrow;
        self.titleLab.transform = item.isZoom ? zoomTransfrom:defaultTransfrom;

        self.titleLab.textColor = textColor;
    }
}

@end
