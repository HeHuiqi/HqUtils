//
//  HHPullDownContentView.h
//  HqUtils
//
//  Created by hehuiqi on 2021/4/2.
//  Copyright © 2021 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HHPullDownContentViewDelegate;
@interface HHPullDownContentView : UIView

@property(nonatomic,weak) id<HHPullDownContentViewDelegate> delegate;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;

@end

@protocol HHPullDownContentViewDelegate <NSObject>

- (void)hhPullDownContentView:(HHPullDownContentView *)view selectedItem:(id _Nullable)item;

@end

NS_ASSUME_NONNULL_END
