//
//  HqTableViewTestVC.m
//  HqUtils
//
//  Created by hehuiqi on 7/1/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqTableViewTestVC.h"
#import "HqShortArticleCell.h"
#import "HqShortArticle.h"
#import "HqTestCell.h"

#import "HqShareShortArticleView.h"
#import "HqTitleView.h"

@interface HqTableViewTestVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HqTitleView *titleView;

@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HqShareShortArticleView *shareView;
@property (nonatomic,strong) UIImageView *showImageView;



@end

@implementation HqTableViewTestVC

- (HqShareShortArticleView *)shareView{
    if (!_shareView) {
        _shareView = [[HqShareShortArticleView alloc] initWithFrame:CGRectMake(15, self.navBarHeight, SCREEN_WIDTH-30, SCREEN_HEIGHT-self.navBarHeight)];
    }
    return _shareView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.shareView];
    self.title = @"title";
    
    self.datas = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (int i = 0; i<500; i++) {
        [self.datas addObject:@""];
    }

    [self initView];
    
    self.showImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.showImageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.showImageView];
    self.showImageView.hidden = YES;
    
    self.titleView = [[HqTitleView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.titleView.titleLab.text = @"我的标题";
    self.titleView.userIcon.image = [UIImage imageNamed:@"longmao.jpeg"];
    self.titleView.scollView = self.tableView;
    self.navigationItem.titleView = self.titleView;
    
    
}
- (void)initView{
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, self.navBarHeight, self.view.bounds.size.width, self.view.bounds.size.height-self.navBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = kZoomValue(150);
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    HqTestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HqTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
  
    

}




@end
