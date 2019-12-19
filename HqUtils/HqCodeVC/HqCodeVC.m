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



@interface HqCodeVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSUInteger page;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *datas;



@end

@implementation HqCodeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐作者";
    self.datas = [[NSMutableArray alloc] init];
    self.page = 1;
    [self.datas addObject:@""];
    [self.datas addObject:@""];
    
    [self  initView];
}

- (void)initView{
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(self.navBarHeight);
//        make.left.equalTo(self.view).offset(0);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.bottom.equalTo(self.view).offset(0);
//    }];
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.estimatedRowHeight = SCREEN_WIDTH+80;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        static NSString *cellIdentifer = @"HqTopicBannerCell";
        HqTopicBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
        if (!cell) {
            cell = [[HqTopicBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        }
        return cell;
    }
    static NSString *cellIdentifer = @"HqNewTopicCell";
    HqNewTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[HqNewTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.topics = @[@"1sfsgs",@"1sfsgs",@"1sfsgs",@"1sfsgs",@"1sfsgs",@"1sfsgs",];
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

