//
//  HqNewTopicContainerView.m
//  HqUtils
//
//  Created by hehuiqi on 2019/11/30.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqNewTopicContainerView.h"
#import "HqNewTopicItemBtn.h"

@interface HqNewTopicContainerView ()

@property(nonatomic,strong) NSMutableArray *btnItems;
@property(nonatomic,strong) UIView *centerLine;

@end

@implementation HqNewTopicContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}
- (UIView *)centerLine{
    if (!_centerLine) {
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = LineColor;
    }
    return _centerLine;
}
- (void)setup{
    self.btnItems = [[NSMutableArray alloc] init];
    CGFloat btnW = SCREEN_WIDTH/2.0;
    CGFloat btnH = 30;
    for (int i = 0; i<6; i++) {
        HqNewTopicItemBtn *btn = [[HqNewTopicItemBtn alloc] init];
        [self addSubview:btn];
        CGFloat x = i%2;
        CGFloat y = i/2;
//        CGFloat x = i/3;
//        CGFloat y = i%3;
        
        btn.frame = CGRectMake(x*btnW, y*btnH, btnW, btnH);
        [self.btnItems addObject:btn];
        btn.backgroundColor = HqRandomColor;
    }
    [self addSubview:self.centerLine];
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(LineHeight);
    }];
}
- (void)setTopics:(NSArray *)topics{
    _topics = topics;
    if (topics) {
        for (int i = 0; i<topics.count; i++) {
            id topic = topics[i];
            if (i<self.btnItems.count) {
                HqNewTopicItemBtn *itemBtn = self.btnItems[i];
                itemBtn.topic = topic;
            }
        }
    }
}
- (void)hqLayoutSuviews{
    
}
@end
