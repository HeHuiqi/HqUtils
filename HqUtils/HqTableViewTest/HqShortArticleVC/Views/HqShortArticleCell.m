//
//  HqShortArticleCell.m
//  HqUtils
//
//  Created by hehuiqi on 7/1/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqShortArticleCell.h"

@implementation HqShortArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
    _lineView = [[HqShortArticleLineView alloc] init];
    
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(8));
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(10);
    }];
    
    _timeBtn = [[UIButton alloc] init];
    _timeBtn.backgroundColor = HqRandomColor;
    [self addSubview:_timeBtn];
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(7));
        make.top.equalTo(self).offset(kZoomValue(5));
        make.size.mas_equalTo(CGSizeMake(kZoomValue(50), kZoomValue(15)));
    }];
    
    _titleLab = [[UILabel alloc] init];
    [self addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kZoomValue(25));
        make.left.equalTo(self).offset(kZoomValue(20));
        make.right.equalTo(self).offset(kZoomValue(-15));
    }];
    _contentLab = [[UILabel alloc] init];
    _contentLab.font = [UIFont systemFontOfSize:15];
    _contentLab.numberOfLines = 3;
    [self addSubview:_contentLab];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(kZoomValue(10));
        make.left.equalTo(self).offset(kZoomValue(20));
        make.bottom.equalTo(self).offset(kZoomValue(-40));
        make.right.equalTo(self).offset(kZoomValue(-15));
    }];
    
    _shareBtn = [[UIButton alloc] init];
    [self addSubview:_shareBtn];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kZoomValue(-15));
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(50), kZoomValue(30)));
    }];
    _shareBtn.backgroundColor = HqRandomColor;
    [_shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
   
    
}
- (void)shareClick:(UIButton *)btn{
    if (self.delegate) {
        [self.delegate hqShortArticleCell:self clickShareBtn:btn];
    }
}
- (void)setShortArticle:(HqShortArticle *)shortArticle{
    _shortArticle = shortArticle;
    if (_shortArticle) {
        _titleLab.text = @"标题标题";
        if (shortArticle.open) {
            _contentLab.numberOfLines = 0;
        }else{
//            _contentLab.text = shortArticle.short_content;
            _contentLab.numberOfLines = 3;
        }
        _contentLab.text = shortArticle.content;
    }
}
@end
