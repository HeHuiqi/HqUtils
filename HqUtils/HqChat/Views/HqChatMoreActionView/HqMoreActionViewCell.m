//
//  HqMoreActionViewCell.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/12.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqMoreActionViewCell.h"

@interface HqMoreActionViewCell ()

@property(nonatomic,strong) NSMutableArray *itemViews;

@end
@implementation HqMoreActionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _actionBtn;
}
- (UILabel *)actionInfoLab{
    if (!_actionInfoLab) {
        _actionInfoLab = [[UILabel alloc] init];
        _actionInfoLab.font = SetFont(11);
        _actionInfoLab.textColor = HqLightGrayColor;
    }
    return _actionInfoLab;
}
- (void)setup{
    self.itemViews = [NSMutableArray array];
    for (int i = 0; i<8; i++) {
        HqMoreActionItemView *itemView = [[HqMoreActionItemView alloc] init];
        [itemView.actionBtn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemView];
        [self.itemViews addObject:itemView];
    }
}
- (void)actionBtnClick:(UIButton *)btn{
    HqMoreActionItemView *view = (HqMoreActionItemView *)btn.superview;
    if ([self.delegate respondsToSelector:@selector(morecActionClickItem:)] && self.delegate) {
        [self.delegate morecActionClickItem:view.item];
    }
    
}
- (void)setItems:(NSArray *)items{
    _items = items;
    for (UIView *view  in self.itemViews) {
        view.hidden = YES;
    }
    if (items.count>0) {
        for (int i = 0; i<items.count; i++) {
            HqMoreActionItemView *itemView = self.itemViews[i];
            HqListItemModel *item = items[i];
            itemView.item = item;
            itemView.hidden = NO;
        }
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    CGFloat itemW = width/4;
    CGFloat itemH = height/2;
    for (int i = 0; i<self.itemViews.count; i++) {
        CGFloat itemX = i%4;
        CGFloat itemY = i/4;
        HqMoreActionItemView *itemView = self.itemViews[i];
        itemView.frame = CGRectMake(itemX*itemW, itemY*itemH, itemW, itemH);
    }
}
@end
