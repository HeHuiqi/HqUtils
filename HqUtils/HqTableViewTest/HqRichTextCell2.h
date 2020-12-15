//
//  HqRichTextCell.h
//  HqUtils
//
//  Created by hehuiqi on 10/12/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText/YYLabel.h>
NS_ASSUME_NONNULL_BEGIN

@interface HqRichTextCell2 : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong) UIImageView *userIcon;
@property(nonatomic,strong) UITextView *contentTv;
@property(nonatomic,strong) YYLabel *contentLab;

@property(nonatomic,strong) UIView *bottomView;
@property (nonatomic,copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
