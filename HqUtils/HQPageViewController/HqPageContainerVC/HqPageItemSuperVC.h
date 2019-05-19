//
//  HqPageItemSuperVCh
//  HqUtils
//
//  Created by hehuiqi on 5/18/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqPageViewProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface HqPageItemSuperVC : UIViewController<UIScrollViewDelegate>

//代理或者block回调二选其一
@property(nonatomic,copy) HqPageItemScrollViewOffetYBlock pageItemOffsetYBlock;
@property (nonatomic,weak) id<HqPageViewProtocol> delegate;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,assign) BOOL canScroll;

- (void)hqScorllToTop;
//子类实现
- (void)refreshData;



@end

NS_ASSUME_NONNULL_END
