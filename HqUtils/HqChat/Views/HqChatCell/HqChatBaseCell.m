//
//  HqChatBaseCell.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatBaseCell.h"

@implementation HqChatBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (UIButton *)selecteBtn{
    if (_selecteBtn) {
        _selecteBtn = [[UIButton alloc] init];
        _selecteBtn.userInteractionEnabled = NO;
        [_selecteBtn setImage:[UIImage imageNamed:@"lc_chat_check_icon"] forState:UIControlStateNormal];
        [_selecteBtn setImage:[UIImage imageNamed:@"lc_chat_checked_icon"] forState:UIControlStateSelected];
    }
    return _selecteBtn;
}
- (UILabel *)nicknameLab{
    if (!_nicknameLab) {
        _nicknameLab = [[UILabel alloc] init];
        _nicknameLab.font = SetFont(11);
    }
    return _nicknameLab;
}
- (UIImageView *)mContentView{
    if (!_mContentView) {
        _mContentView = [[UIImageView alloc] init];
        _mContentView.backgroundColor = [UIColor whiteColor];
        _mContentView.clipsToBounds = YES;
        _mContentView.layer.cornerRadius = 4;
        _mContentView.userInteractionEnabled = YES;
    }
    return _mContentView;
}
- (UIImageView *)userIcon{
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] init];
        _userIcon.contentMode = UIViewContentModeScaleAspectFill;
        _userIcon.clipsToBounds = YES;
        _userIcon.backgroundColor = HqLightGrayColor;
    }
    return _userIcon;
}
- (UILabel *)mTextLab{
    if (!_mTextLab) {
        _mTextLab = [[UILabel alloc] init];
        _mTextLab.numberOfLines = 0;
        _mTextLab.font = SetFont(15);
    }
    return _mTextLab;
}
- (UIImageView *)mImageView{
    if (!_mImageView) {
        _mImageView = [[UIImageView alloc] init];
        _mImageView.contentMode = UIViewContentModeScaleAspectFill;
        _mImageView.clipsToBounds = YES;
        _mImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [_mImageView addGestureRecognizer:imageTap];
    }
    return _mImageView;
}
- (void)tapImage:(UITapGestureRecognizer *)tap{
    NSLog(@"tapImage==%@",tap);
    if ([self.delegate respondsToSelector:@selector(HqChatBaseCellOnClickImageCell:)] && self.delegate) {
        [self.delegate HqChatBaseCellOnClickImageCell:self];
    }
}
- (void)setup{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.selecteBtn];
    [self addSubview:self.userIcon];
    [self addSubview:self.nicknameLab];
    
    [self addSubview:self.mContentView];
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPressGR];
}
- (void)hqLayoutSubviews{

}
- (void)longPress:(UILongPressGestureRecognizer *)pg{

    if (pg.state == UIGestureRecognizerStateBegan) {
//        [self showOptMenu];
        if ([self.delegate respondsToSelector:@selector(HqChatBaseCellOnClickImageCell:)] && self.delegate) {
            [self.delegate HqChatBaseCellOnLongPressCell:self];
        }
    }
}

- (void)fromMeMessageBaseLayout{
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    self.userIcon.layer.cornerRadius = 19;
    [self.nicknameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userIcon.mas_left).offset(-10);
        make.top.equalTo(self.userIcon.mas_top);
    }];
    [self.mContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userIcon.mas_left).offset(-10);
        make.left.mas_greaterThanOrEqualTo(self).offset(80);
        make.top.equalTo(self.nicknameLab.mas_bottom).offset(5);
        make.bottom.equalTo(self).offset(-10);
    }];
}

- (void)fromOtherMessageBaseLayout{
 
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    self.userIcon.layer.cornerRadius = 19;

    [self.nicknameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(10);
        make.top.equalTo(self.userIcon.mas_top);
    }];
    [self.mContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(10);
        make.right.mas_lessThanOrEqualTo(self).offset(-80);
        make.top.equalTo(self.nicknameLab.mas_bottom).offset(5);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    
}

- (void)showOptMenuIsNeedBecomFirstResponser:(BOOL)isNeed{
    if (isNeed) {
        [self becomeFirstResponder];
    }
    CGRect targetRect = CGRectZero;
    UIMenuController * menu = [UIMenuController sharedMenuController];
    if (self.message.messageType == HqChatMessageTypeText) {
        CGRect rect =  self.mTextLab.bounds;
        targetRect = CGRectMake(10, 0, rect.size.width, rect.size.height);
        UIMenuItem * item0 = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(hqCopy:)];
        UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"禁言" action:@selector(hqShutup:)];
        menu.menuItems = @[item0,item1];
    }else{
        CGRect rect =  self.mImageView.bounds;
        targetRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
        UIMenuItem * item0 = [[UIMenuItem alloc]initWithTitle:@"转发" action:@selector(hqForwardImage:)];
        UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"禁言" action:@selector(hqShutup:)];
        menu.menuItems = @[item0,item1];

    }
    [menu setTargetRect:targetRect inView:self.mContentView];
    [menu setMenuVisible:YES animated:YES];
}
- (void)hqCopy:(UIMenuItem *)item{
    NSLog(@"复制");
}
- (void)hqShutup:(UIMenuItem *)item{
    
    NSLog(@"闭嘴");

}
- (void)hqForwardImage:(UIMenuItem *)item{
    NSLog(@"转发图片");
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(hqCopy:)){
          return YES;
    }else if (action == @selector(hqShutup:)){
        return YES;
    }
    else if (action == @selector(hqForwardImage:)){
        return YES;
    }
    return NO;

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
