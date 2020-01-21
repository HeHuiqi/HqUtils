//
//  HqPageItemSuperVCm
//  HqUtils
//
//  Created by hehuiqi on 5/18/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqPageItemSuperVC.h"

@interface HqPageItemSuperVC ()

@end

@implementation HqPageItemSuperVC
- (instancetype)init{
    if (self = [super init]) {
        self.canScroll = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)hqScorllToTop{
    self.scrollView.contentOffset = CGPointZero;
}
- (void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
//    self.scrollView.showsVerticalScrollIndicator = _canScroll;
}
- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
}
- (void)refreshData{
    //子类实现
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    //    NSLog(@"yy = %@",@(y));
    if (self.canScroll) {
        if (y<=0) {
            scrollView.contentOffset = CGPointZero;
            self.canScroll = NO;
            //由SegmentPageView实现
            if (self.pageItemOffsetYBlock) {
                self.pageItemOffsetYBlock(self, y);
            }
            if (self.delegate) {
                [self.delegate hqPageItemVC:self scrollViewOffetY:y];
            }
        }
    }else{
        scrollView.contentOffset = CGPointZero;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
