//
//  HqChatBaseCell.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqChatMessage.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HqChatBaseCellDelegate;
@interface HqChatBaseCell : UITableViewCell

@property(nonatomic,weak) id<HqChatBaseCellDelegate> delegate;
@property(nonatomic,strong) UIButton *selecteBtn;
@property(nonatomic,strong) UIImageView *userIcon;
@property(nonatomic,strong) UILabel *nicknameLab;


@property(nonatomic,strong) UIImageView *mContentView;

@property(nonatomic,strong) UILabel *mTextLab;//文本
@property(nonatomic,strong) UIImageView *mImageView;//图片

@property(nonatomic,strong) HqChatMessage *message;



- (void)setup;
- (void)hqLayoutSubviews;

- (void)fromMeMessageBaseLayout;
- (void)fromOtherMessageBaseLayout;

- (void)showOptMenuIsNeedBecomFirstResponser:(BOOL)isNeed;

@end

@protocol HqChatBaseCellDelegate <NSObject>

@optional
//点击图片
- (void)HqChatBaseCellOnClickImageCell:(HqChatBaseCell *)cell;
//长按Cell
- (void)HqChatBaseCellOnLongPressCell:(HqChatBaseCell *)cell;
- (void)HqChatBaseCellUser:(HqChatBaseCell *)cell;

@end

NS_ASSUME_NONNULL_END
