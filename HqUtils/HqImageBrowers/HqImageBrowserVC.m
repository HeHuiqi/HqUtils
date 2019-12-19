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
    browserView.currentPage = 0;
    browserView.imageDatas = @[@"https://cdn.lcyoufu.com/assets/sign/rsk.png",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576753360761&di=4a72a32847e20b35cf07195344115465&imgtype=jpg&src=http%3A%2F%2Fimg8.zol.com.cn%2Fbbs%2Fupload%2F19485%2F19484298.jpg",@"https://img-blog.csdnimg.cn/20191216172544126.png"];
    [browserView showInView:nil thumbImageView:nil];
    
}


@end


