//
//  HqNewTopicCell.m
//  HqUtils
//
//  Created by hehuiqi on 2019/11/30.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqNewTopicCell.h"


@implementation HqNewTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIView *)topLine{
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _topLine;
}
- (HqNewTopicHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HqNewTopicHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}
- (HqNewTopicContainerView *)topicContninerView{
    if (!_topicContninerView) {
        _topicContninerView = [[HqNewTopicContainerView alloc] init];
        _topicContninerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _topicContninerView;
}
- (void)setup{
    [self addSubview:self.topLine];
    [self addSubview:self.headerView];
    [self addSubview:self.topicContninerView];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, kZoomValue(8)));
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLine.mas_bottom).offset(0);
        make.left.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, kZoomValue(36)));
    }];
    [self.topicContninerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.left.equalTo(self).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 90));
        make.bottom.equalTo(self).offset(kZoomValue(-8));
    }];
}
- (void)setTopics:(NSArray *)topics{
    _topics = topics;
    self.topicContninerView.topics = topics;
}
- (void)hqLayoutSubviews{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
