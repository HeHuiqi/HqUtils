//
//  HqChatOtherImageCell.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatOtherImageCell.h"

@implementation HqChatOtherImageCell
-(void)setup{
    [super setup];
    [self.mContentView addSubview:self.mImageView];
    [self fromOtherMessageBaseLayout];
}
- (void)fromOtherMessageBaseLayout{
    [super fromOtherMessageBaseLayout];
    [self.mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mContentView).offset(0);
        make.left.equalTo(self.mContentView).offset(0);
        make.right.equalTo(self.mContentView).offset(0);
        make.bottom.equalTo(self.mContentView).offset(0);
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(140);
    }];
}
- (void)setMessage:(HqChatMessage *)message{
    [super setMessage:message];
    self.nicknameLab.text = message.nickname;
    if (message.localImage) {
        self.mImageView.image = message.localImage;
    }else{
        if (message.imageUrl) {
            NSURL *url = [NSURL URLWithString:message.imageUrl];
            [self.mImageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                message.localImage = image;
            }];
        }
    }
    
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
