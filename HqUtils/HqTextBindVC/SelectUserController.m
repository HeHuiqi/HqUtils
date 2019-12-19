//
//  SelectUserController.m
//  ATDemo
//
//  Created by lisong on 2018/5/25.
//  Copyright © 2018年 lisong. All rights reserved.
//

#import "SelectUserController.h"

@interface SelectUserController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,assign) NSInteger page;

@end

@implementation SelectUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(self.navBarHeight);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(0);
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma mark -  UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kZoomValue(60);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"用户😊%ld",(long)indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
      if (self.selectBlock)
      {
          self.selectBlock(cell.textLabel.text);
      }
      
      [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 请求
- (void)refreshData{
    
}
- (void)loadData{
    
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

