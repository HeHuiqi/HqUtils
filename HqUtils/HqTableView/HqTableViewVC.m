//
//  HqTableViewVC.m
//  HqUtils
//
//  Created by hehuiqi on 9/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTableViewVC.h"
#import "HqRichTextCell.h"

@interface HqTableViewVC ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,assign) NSUInteger page;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) HqCellModel *cellmodel;



@end

@implementation HqTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"刷新---viewDidLoadviewDidLoadviewDidLoad");

    self.title = @"title";
    self.datas = [[NSMutableArray alloc] initWithCapacity:4];
    self.cellmodel = [[HqCellModel alloc] init];
//    self.cellmodel.content = @"双卡双待噶的根深蒂固说广安市速度快噶说的噶说的跟哈是的啊是个撒蛋糕阿森松岛赶快拉屎森岛宽晃撒到噶";
//    self.cellmodel.imageUrl = @"https://cdn.lcyoufu.com/user/1470/weiwen/28227d9c92aa14df0cfae1cea59ea8d9.jpg?x-oss-process=style/style";
    [self.datas addObject:self.cellmodel];
    [self initView];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.cellmodel = [[HqCellModel alloc] init];
        self.cellmodel.content = @"双卡双待噶的根深蒂固说广安市速度快噶说的噶说的跟哈是的啊是个撒蛋糕阿森松岛赶快拉屎森岛宽晃撒到噶";
        self.cellmodel.imageUrl = @"https://cdn.lcyoufu.com/user/1470/weiwen/28227d9c92aa14df0cfae1cea59ea8d9.jpg?x-oss-process=style/style";
        NSLog(@"刷新---");
        [self.tableView reloadData];
    });
}
- (void)initView{
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = SCREEN_HEIGHT*100;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    HqCellModel *cellModel = self.datas[indexPath.row];
    HqRichTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HqRichTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.cellModel = cellModel;
//    cell.imageViweSizeChange = ^{
//        [tableView reloadData];
//    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)refreshData{
    self.page = 1;
}
- (void)loadData{
    self.page ++;
}


@end
