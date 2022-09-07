//
//  HqLocalPaintVC.m
//  HqUtils
//
//  Created by hehuiqi on 2021/8/31.
//  Copyright © 2021 hhq. All rights reserved.
//

#import "HqLocalPaintVC.h"
#import "HqLocalPintListCell.h"
#import "HqPaintFileManager.h"
@interface HqLocalPaintVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSUInteger page;
@property(nonatomic,strong) NSArray *datas;
@property(nonatomic,strong) UITableView *tableView;



@end

@implementation HqLocalPaintVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的绘图";
    self.page = 1;
    self.datas = @[];
    
    [self  initView];
    [self loadLocalPaintFiles];
}

- (void)initView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.navBarHeight);
        make.left.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"UITableViewCell";
    HqLocalPintListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[HqLocalPintListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.fileName = self.datas[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HqLocalPintListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(hqLocalPaintVC:paintLayer:)] && self.delegate) {
        [self.delegate hqLocalPaintVC:self paintLayer:cell.paintLayer];
    }
    Back();
}
- (void)loadLocalPaintFiles{
    self.datas = [HqPaintFileManager allPaintFiles];
    [self.tableView reloadData];
}

@end

