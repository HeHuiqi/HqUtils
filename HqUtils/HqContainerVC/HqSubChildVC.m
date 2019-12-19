//
//  HqSubChildVC.m
//  HqUtils
//
//  Created by hehuiqi on 2019/11/29.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqSubChildVC.h"

#import "HqContainerVC.h"
#import "HqSubContainerVC.h"

@interface HqSubChildVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSUInteger page;

@property(nonatomic,strong) NSMutableArray *datas;



@end

@implementation HqSubChildVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐作者";
    self.datas = [[NSMutableArray alloc] init];
    for (int i = 0; i<20; i++) {
        [self.datas addObject:@(i).stringValue];
    }
    self.page = 1;
    self.canScroll = NO;
    [self  initView];
}

- (void)initView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y<=0 || self.canScroll==NO) {
        scrollView.contentOffset = CGPointZero;
        self.canScroll = NO;
        HqContainerVC *vc = (HqContainerVC *)self.parentViewController.parentViewController;
        vc.canScroll = YES;
        HqSubContainerVC *subContainerVC = (HqSubContainerVC *)self.parentViewController;
        for (HqSubChildVC *vc  in subContainerVC.childViewControllers) {
            if (![vc isEqual:self]) {
                vc.tableView.contentOffset = CGPointZero;
            }
        }
    }
}
- (void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
}
@end

