//
//  HqChatOtherTextCell.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatOtherTextCell.h"

@implementation HqChatOtherTextCell

- (void)setup{
    [super setup];
    [self.mContentView addSubview:self.mTextLab];
    [self fromOtherMessageBaseLayout];
}

- (void)fromOtherMessageBaseLayout{
    [super fromOtherMessageBaseLayout];
    [self.mTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mContentView).offset(10);
        make.left.equalTo(self.mContentView).offset(10);
        make.right.equalTo(self.mContentView).offset(-10);
        make.bottom.equalTo(self.mContentView).offset(-10);
    }];
}
- (void)setMessage:(HqChatMessage *)message{
    [super setMessage:message];
    self.nicknameLab.text = message.nickname;
    self.mTextLab.text = message.content;
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
