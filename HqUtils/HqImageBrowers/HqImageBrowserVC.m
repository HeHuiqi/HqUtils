//
//  HqImageBrowersVC.m
//  HqUtils
//
//  Created by hehuiqi on 11/5/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqImageBrowserVC.h"
#import "HqBigImagePreview.h"
#import "HqTimeLineCell.h"

#import "HqImageBrowserView.h"

@interface HqImageBrowserVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,assign) NSInteger page;


@end

@implementation HqImageBrowserVC

- (void)viewDidLoad {
    self.datas = [[NSMutableArray alloc] init];
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
    return 190;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"HqTimeLineCell";
    HqTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HqTimeLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UITapGestureRecognizer *tapSmallView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSmallImage:)];
     [cell.smallImageView addGestureRecognizer:tapSmallView];
    return cell;
}
- (void)tapSmallImage:(UITapGestureRecognizer *)tap{
    UIImageView *imgv = (UIImageView *)tap.view;
    HqBigImagePreview *preview = [[HqBigImagePreview alloc] init];
    [preview showInView:nil thumbImageView:imgv];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HqTimeLineCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    HqImageBrowserView *browserView = [[HqImageBrowserView alloc] init];
    browserView.thumbImageView  = cell.smallImageView;
    browserView.currentPage = 1;
    browserView.imageDatas = @[@"",@"",@""];
    [browserView showInView:nil thumbImageView:nil];
    
}


@end


