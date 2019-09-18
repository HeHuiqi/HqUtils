//
//  HqShortArticleCell.h
//  HqUtils
//
//  Created by hehuiqi on 7/1/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqShortArticle.h"
#import "HqShortArticleLineView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HqShortArticleCellDelegate;
@interface HqShortArticleCell : UITableViewCell

@property (nonatomic,weak) id<HqShortArticleCellDelegate> delegate;

@property (nonatomic,strong) HqShortArticleLineView *lineView;
@property (nonatomic,strong) UIButton *timeBtn;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIButton *shareBtn;

@property (nonatomic,strong) HqShortArticle *shortArticle;


@end

@protocol HqShortArticleCellDelegate <NSObject>

@optional
- (void)hqShortArticleCell:(HqShortArticleCell *)cell clickShareBtn:(UIButton *)btn;

@end


NS_ASSUME_NONNULL_END
