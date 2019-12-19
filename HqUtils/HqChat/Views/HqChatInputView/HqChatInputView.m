//
//  HqChatInputView.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatInputView.h"

@interface HqChatInputView ()<UITextViewDelegate,HqMoreActionViewProtocol>

@end

@implementation HqChatInputView
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (UIView *)topInputContentView{
    if (!_topInputContentView) {
        _topInputContentView = [[UIView alloc] init];
        _topInputContentView.backgroundColor = [UIColor whiteColor];
    }
    return _topInputContentView;
}
- (UITextView *)mTextView{
    if (!_mTextView) {
        _mTextView = [[HqChatInputTextView alloc] init];
        _mTextView.returnKeyType = UIReturnKeySend;
        _mTextView.enablesReturnKeyAutomatically = YES;
        _mTextView.delegate = self;
        _mTextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _mTextView;
}
- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setImage:[UIImage imageNamed:@"lc_chat_add_icon"] forState:UIControlStateNormal];
        [_addBtn  addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
- (void)addBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.inputViewStatus = HqChatInputViewStatusAdd;
        self.moreActionView.hidden = NO;
        if ([self.mTextView isFirstResponder]) {
            [self.mTextView resignFirstResponder];
        }else{
            [self notifySelfHeightChange:300 changeTime:0.3];
        }
    }else{
        if (![self.mTextView isFirstResponder]) {
            self.moreActionView.hidden = YES;
            [self.mTextView becomeFirstResponder];
        }
    }
    
}
- (UIView *)inputBottomLine{
    if (!_inputBottomLine) {
        _inputBottomLine = [[UIView alloc] init];
        _inputBottomLine.backgroundColor = LineColor;
    }
    return _inputBottomLine;
}
- (HqChatMoreActionView *)moreActionView{
    if (!_moreActionView) {
        _moreActionView = [[HqChatMoreActionView alloc] init];
        _moreActionView.hidden = YES;
        _moreActionView.delegate = self;
    }
    return _moreActionView;
}
- (void)hqLayoutSuviews{
    
    
    [self.topInputContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    
    [self.mTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topInputContentView).offset(50);
        make.right.equalTo(self.topInputContentView).offset(-50);
        make.centerY.equalTo(self.topInputContentView);
        make.height.mas_equalTo(30);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topInputContentView).offset(0);
        make.centerY.equalTo(self.topInputContentView);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    
    [self.inputBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self.topInputContentView.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(LineHeight);
    }];
    
    [self.moreActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self.inputBottomLine.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(300);
    }];
    
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topInputContentView];
    [self.topInputContentView addSubview:self.mTextView];
    [self.topInputContentView addSubview:self.addBtn];
    [self addSubview:self.inputBottomLine];
    [self addSubview:self.moreActionView];

    
    [self hqLayoutSuviews];
    
    //键盘显示 回收的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘显示监听事件
- (void)keyboardWillChange:(NSNotification *)notify{
    double changeTime   = [[notify userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat height = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    if(notify.name == UIKeyboardWillHideNotification){
        //键盘消失
        if (self.inputViewStatus == HqChatInputViewStatusAdd) {
            height = 300;
        }else{
            height = 0;
        }
    }else{
        //键盘弹出
    }
//    NSLog(@"keyBoardHeight == %@",@(height));
    [self notifySelfHeightChange:height changeTime:changeTime];

}
- (void)notifySelfHeightChange:(CGFloat)height changeTime:(CGFloat)changeTime{
    if ([self.delegate respondsToSelector:@selector(hqChatInputViewKeyBoardHeight:changeTime:)] && self.delegate) {
          [self.delegate hqChatInputViewKeyBoardHeight:height changeTime:changeTime];
      }
}
- (void)mTextViewResignFirstResponder{
    self.inputViewStatus = HqChatInputViewStatusEdit;
    if ([self.mTextView isFirstResponder]) {
        [self.mTextView resignFirstResponder];

    }else{
        [self notifySelfHeightChange:0 changeTime:0.3];
    }
}
#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.inputViewStatus = HqChatInputViewStatusEdit;
    self.moreActionView.hidden = YES;
    self.addBtn.selected = NO;
}
- (void)textViewDidChange:(UITextView *)textView{
    
}
//拦截发送按钮
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(text.length==0){
//        [[SSChartEmotionImages ShareSSChartEmotionImages] deleteEmtionString:self.mTextView];
//        [self textViewDidChange:self.mTextView];
        return YES;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [self startSendMessage];
        return NO;
    }
    
    return YES;
}
//开始发送消息
-(void)startSendMessage{
    NSString *message = [self.mTextView.attributedText string];
    NSString *newMessage = [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([self.delegate respondsToSelector:@selector(hqChatInputViewDidSendTextMessage:)] && self.delegate) {
        [self.delegate hqChatInputViewDidSendTextMessage:newMessage];
    }
    self.mTextView.text = @"";

}
#pragma mark - HqMoreActionViewProtocol
- (void)morecActionClickItem:(HqListItemModel *)item{
    if ([self.delegate respondsToSelector:@selector(hqChatInputViewDidClickItem:)] && self.delegate) {
        [self.delegate hqChatInputViewDidClickItem:item];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
