//
//  HqLoopScrollVIew.m
//  HqUtils
//
//  Created by hehuiqi on 2020/1/21.
//  Copyright © 2020 hhq. All rights reserved.
//

#import "HqLoopScrollVIew.h"
#import "HqWeakTarget.h"

@interface HqLoopScrollVIew ()<UIScrollViewDelegate>


@end

@implementation HqLoopScrollVIew
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)dealloc{
    NSLog(@"dealloc");
    [self destroyTimer];
}
- (NSTimer *)loopTimer{
    if (!_loopTimer) {
        _loopTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:[HqWeakTarget weakTarget:self] selector:@selector(nextItemView) userInfo:nil repeats:YES];
    }
    return _loopTimer;
}


- (void)destroyTimer{
    if (_loopTimer) {
        [_loopTimer invalidate];
        _loopTimer = nil;
    }
}
- (void)nextItemView{
    NSLog(@"---");
    if (self.datas.count<=1) {
        [self destroyTimer];
        return;
    }
    CGPoint currentOffset = self.scrollView.contentOffset;
    currentOffset.x = currentOffset.x + self.bounds.size.width;
    [self.scrollView setContentOffset:currentOffset animated:YES];
    
    [self nextItem];
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (HqLoopScrollItemView *)lastView{
    if (!_lastView) {
        _lastView = [[HqLoopScrollItemView alloc] init];
    }
    return _lastView;
}
- (HqLoopScrollItemView *)currentView{
    if (!_currentView) {
        _currentView = [[HqLoopScrollItemView alloc] init];
    }
    return _currentView;
}
- (HqLoopScrollItemView *)nextView{
    if (!_nextView) {
        _nextView = [[HqLoopScrollItemView alloc] init];
    }
    return _nextView;
}
- (NSTimeInterval)timeInterval{
    if (_timeInterval <= 0) {
        return 2;
    }
    return _timeInterval;
}
- (void)setup{
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.lastView];
    [self.scrollView addSubview:self.currentView];
    [self.scrollView addSubview:self.nextView];
    
    self.lastView.titleLab.font = self.currentView.titleLab.font = self.nextView.titleLab.font = [UIFont boldSystemFontOfSize:30];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.scrollView.frame = CGRectMake(0, 0, width, height);
    self.lastView.frame = CGRectMake(0, 0, width, height);
    self.currentView.frame = CGRectMake(width, 0, width, height);
    self.nextView.frame = CGRectMake(width*2, 0, width, height);

}
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    self.currentIndex = 0;
    if (_datas.count>1) {
        if (self.loop) {
            [self loopTimer];
        }
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, 0);
    }else{
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, 0);
    }
    [self refreshData];
}

- (void)refreshData{
    NSInteger index = self.currentIndex;
    self.currentView.scollItem = self.datas[index];
    
    index = (self.currentIndex-1)<0 ? self.datas.count-1:self.currentIndex-1;
    self.lastView.scollItem = self.datas[index];
    
    index = ((self.currentIndex+1)>=self.datas.count) ? 0:self.currentIndex+1;
    self.nextView.scollItem = self.datas[index];
    //保持在中间
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
}
- (void)nextItem{
    [self refreshCurrentIndex];
    [self refreshData];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self destroyTimer];
    [self nextItem];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self restartTimerWithIsDecelerate:decelerate];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self restartTimerWithIsDecelerate:scrollView.isDecelerating];
}
- (void)restartTimerWithIsDecelerate:(BOOL)isDecelerate{
    if (isDecelerate == NO && self.loop) {
        [self loopTimer];
    }
}

//更新index
- (void)refreshCurrentIndex
{
    if (self.scrollView.contentOffset.x >= CGRectGetWidth(self.bounds)*1.5) {
        //向左滑
        _currentIndex ++;
        if (_currentIndex > self.datas.count-1) {
            _currentIndex = 0;
        }
    }else if (self.scrollView.contentOffset.x < CGRectGetWidth(self.bounds)*0.5){
        //向右滑
        _currentIndex --;
        if (_currentIndex < 0) {
            _currentIndex = self.datas.count-1;
        }
    }
}
//-----test
- (void)testData{
    NSMutableArray *imageDatas = @[].mutableCopy;
    NSArray *netImageUrls = @[@"https://cdn.lcyoufu.com/assets/activity/8a46a9b82b6be2aae059e0ec72fa0de8.jpg?x-oss-process=style/style",
    @"https://cdn.lcyoufu.com/assets/activity/370fc784ec248d6053c95eabdd78ab45.png?x-oss-process=style/style",
    @"https://cdn.lcyoufu.com/assets/activity/e77efb93a01f241cac70191043d264e9.png?x-oss-process=style/style"];
    for (int i = 0; i<3; i++) {
        HqLoopScrollItem *item = [HqLoopScrollItem new];
        item.title = [NSString stringWithFormat:@"----%@",@(i+1)];
//        item.imageName = [NSString stringWithFormat:@"%@.jpg",@(i+1)];
        item.imageUrl = netImageUrls[i];
        [imageDatas addObject:item];
    }
    self.datas = imageDatas;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

