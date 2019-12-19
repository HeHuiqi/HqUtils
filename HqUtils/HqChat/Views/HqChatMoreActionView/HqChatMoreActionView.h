//
//  HqChatMoreActionView.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/12.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HqMoreActionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HqChatMoreActionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,HqMoreActionViewProtocol>

@property(nonatomic,weak) id<HqMoreActionViewProtocol> delegate;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *items;

@end

NS_ASSUME_NONNULL_END
