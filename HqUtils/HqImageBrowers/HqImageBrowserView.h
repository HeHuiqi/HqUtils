//
//  HqImageBrowserView.h
//  HqUtils
//
//  Created by hehuiqi on 11/6/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HqImageBrowserView : UIView

@property(nonatomic,strong) UIImageView *thumbImageView;//缩略视图
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *imageDatas;
@property(nonatomic,assign) NSInteger currentPage;

- (void)showInView:(UIView * _Nullable)inView thumbImageView:(UIImageView * _Nullable)thumbImageView;
@end

NS_ASSUME_NONNULL_END
