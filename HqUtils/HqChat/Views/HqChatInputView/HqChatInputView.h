//
//  HqChatInputView.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,HqChatInputViewStatus) {
    HqChatInputViewStatusEdit,
    HqChatInputViewStatusVoice,
    HqChatInputViewStatusAdd
};
#import "HqChatMoreActionView.h"
#import "HqChatInputTextView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HqChatInputViewDelegate;
@interface HqChatInputView : UIView

@property(nonatomic,weak) id<HqChatInputViewDelegate> delegate;

@property(nonatomic,assign) HqChatInputViewStatus inputViewStatus;
@property(nonatomic,strong) UIView *topInputContentView;

@property(nonatomic,strong) UIButton *voiceBtn;
@property(nonatomic,strong) HqChatInputTextView *mTextView;
@property(nonatomic,strong) UIButton *addBtn;

@property(nonatomic,strong) UIView *inputBottomLine;


@property(nonatomic,strong) HqChatMoreActionView *moreActionView;

- (void)mTextViewResignFirstResponder;
@end

@protocol HqChatInputViewDelegate <NSObject>

@optional
- (void)hqChatInputViewDidSendTextMessage:(NSString *)text;
- (void)hqChatInputViewDidClickItem:(HqListItemModel *)item;

- (void)hqChatInputViewKeyBoardHeight:(CGFloat)keyBoardHeight changeTime:(CGFloat)changeTime;

@end

NS_ASSUME_NONNULL_END
