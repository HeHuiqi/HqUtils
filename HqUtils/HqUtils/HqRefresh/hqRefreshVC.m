//
//  hqRefreshVC.m
//  HqUtils
//
//  Created by hqmac on 2019/1/30.
//  Copyright © 2019 macpro. All rights reserved.
//

#import "hqRefreshVC.h"

#import "HqRefreshHeader.h"
#import "HqRefreshFooter.h"

@interface hqRefreshVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HqRefreshHeader *rh;
@property (nonatomic,strong) HqRefreshFooter *rf;
@property (nonatomic,strong) NSMutableArray *titles;

@end

@implementation hqRefreshVC

- (HqRefreshFooter *)rf{
    if (!_rf) {
        _rf = [[HqRefreshFooter alloc] init];
        _rf.backgroundColor = HqRandomColor;
    }
    return _rf;
}
- (HqRefreshHeader *)rh{
    if (!_rh) {
        _rh = [[HqRefreshHeader alloc] init];
        _rh.backgroundColor = HqRandomColor;
        
    }
    return _rh;
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
        rect = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifer];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)hqRefresh{
    UILabel *topView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    topView.backgroundColor = HqRandomColor;
    topView.text = @"这是顶部";
    topView.textAlignment = NSTextAlignmentCenter;
    topView.textColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    CGFloat y = CGRectGetMaxY(topView.frame);
    self.tableView.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y);
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titles = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i<5; i++) {
        [self.titles addObject:@(i).stringValue];
    }
    [self.view addSubview:self.tableView];
    
    UILabel *header =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    header.text = @"这是表头";
    header.textColor = [UIColor whiteColor];
    header.textAlignment = NSTextAlignmentCenter;
    header.backgroundColor = HqRandomColor;
    UILabel *footer =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    footer.text = @"这是表尾";
    footer.textColor = [UIColor whiteColor];
    footer.textAlignment = NSTextAlignmentCenter;
    footer.backgroundColor = HqRandomColor;
    self.tableView.tableHeaderView = header;
    self.tableView.tableFooterView = footer;
    
    __weak typeof(self) weakSelf = self;
    
    
    //下拉刷新
    self.rh.scrollView = self.tableView;
    self.rh.beginRefreshBlock  = ^{
        //模拟请求
        // NSLog(@"请求网络数据。。。");
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray *newData = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<5; i++) {
            [newData addObject:@(i).stringValue];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //注意这里要先结束刷新，在更新界面
            [strongSelf.rh endRefreshing];
            
            // NSLog(@"请求完成了，刷新界面");
            [strongSelf.titles removeAllObjects];
            strongSelf.titles = newData;
            [strongSelf.tableView reloadData];
            
        });
    };
    
    
    //上拉加载
    self.rf.scrollView = self.tableView;
    self.rf.beginLoadingBlock  = ^{
        //模拟请求
        // NSLog(@"请求网络数据。。。");
        __strong typeof(weakSelf) strongSelf = weakSelf;
        for (int i = 0; i<3; i++) {
            [strongSelf.titles addObject:@(i).stringValue];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.rf endRefreshing];
            
            // NSLog(@"请求完成了，刷新界面");
            [strongSelf.tableView reloadData];
        });
    };
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HQPullRefresh";
   
    [self hqRefresh];
    
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
