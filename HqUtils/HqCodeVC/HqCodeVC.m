//
//  HqCodeVC.m
//  HqUtils
//
//  Created by hehuiqi on 6/21/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCodeVC.h"
#import "HqNewTopicCell.h"
#import "HqTopicBannerCell.h"

#import "HqProgressBarView.h"

#import "HqLoopUpDownView.h"
#import "HqTagControl.h"

#import "HqPullZoomView.h"

@interface HqCodeVC ()<UITableViewDelegate,UITableViewDataSource,HqLoopUpDownViewDelegate>

@property(nonatomic,assign) NSUInteger page;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,strong) HqProgressBarView *progressView;
@property(nonatomic,strong) HqLoopUpDownView *loopView;

@property(nonatomic,strong) HqPullZoomView *zoomView;

@end

@implementation HqCodeVC

- (HqLoopUpDownView *)loopView{
    if (!_loopView) {
        _loopView = [[HqLoopUpDownView alloc] init];
    }
    return _loopView;
}
- (HqPullZoomView *)zoomView{
    if (!_zoomView) {
        _zoomView = [[HqPullZoomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kZoomValue(240))];
        UIImage *bgImage = nil;
        bgImage = [UIImage imageNamed:@"weibo_header.png"];
        bgImage = [UIImage imageNamed:@"my_bg"];
        _zoomView.backgroundColor = [UIColor redColor];
        _zoomView.bgImage = bgImage;
    }
    return _zoomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CodeVC";
    self.isAlphaZeroNavBar = YES;
    self.datas = [[NSMutableArray alloc] init];
    self.page = 1;
    for (int i = 0; i<100; i++) {
        [self.datas addObject:@(i).stringValue];
    }
    [self.view addSubview:self.zoomView];
    

    
    [self.view addSubview:self.tableView];
    CGFloat headerH = CGRectGetHeight(self.zoomView.frame)-self.navBarHeight;
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,headerH) ];
    UIButton *userIcon = [[UIButton alloc] init];
    [userIcon setBackgroundImage:[UIImage imageNamed:@"longmao.jpeg"] forState:UIControlStateNormal];
    CGFloat userIconH = 80;
    userIcon.bounds = CGRectMake(0, 0, userIconH, userIconH);
    userIcon.center = CGPointMake(tableHeader.center.x, tableHeader.center.y-userIconH/2.0);
    userIcon.layer.cornerRadius = 40;
    userIcon.clipsToBounds = YES;
    [tableHeader addSubview:userIcon];
//    tableHeader.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(self.navBarHeight);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(0);
    }];
    self.tableView.tableHeaderView = tableHeader;
    self.zoomView.scrollView = self.tableView;
    

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = offsetY/self.navBarHeight;
    if (offsetY<=0) {
        alpha = 0;
    }
    NSLog(@"alpha==%@",@(alpha));

//    UIColor *color = [UIColor redColor];
//    UIImage *image = [UIImage createImageWithColor:color];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];

}
- (void)loopDownUp{
    [self.view addSubview:self.loopView];
    [self.loopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(self.navBarHeight);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];

    self.loopView.delegate = self;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i<2; i++) {
        HqLoopUpDownItem *item = [HqLoopUpDownItem new];
        item.title = [NSString stringWithFormat:@"lab%@",@(i+1)];
        [items addObject:item];
    }
    self.loopView.items = items;
    self.loopView.backgroundColor = [UIColor purpleColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
//    [self.loopView startLoop];
}
#pragma mark - HqLoopUpDownViewDelegate
- (void)hqLoopUpDownView:(HqLoopUpDownView *)view clickItem:(HqLoopUpDownItem *)item{
    NSLog(@"item==%@",item.title);
}
- (void)initView{

    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight = 100;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    header.backgroundColor = HqRandomColor;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"HqNewTopicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 请求

- (void)refreshData{
    self.page = 1;
    [self getArticles];
    
}
- (void)loadData{
    self.page++;
    [self getArticles];
}
- (void)getArticles{
    [self requsetFollowData];
}
#pragma mark 关注的
- (void)requsetFollowData{
    
 
}
- (void)refreshTableView:(UITableView *)tablview isNomore:(BOOL)isNomore{
    [tablview.mj_header endRefreshing];
    
    if (isNomore) {
        [tablview.mj_footer endRefreshingWithNoMoreData];
        tablview.mj_footer.alpha = 1.0;
    }else{
        [tablview.mj_footer endRefreshing];
        tablview.mj_footer.alpha = 1.0;
    }
    [tablview reloadData];
}
@end

