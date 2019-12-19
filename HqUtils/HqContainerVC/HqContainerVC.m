//
//  HqContainerVC.m
//  HqUtils
//
//  Created by hehuiqi on 2019/11/29.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqContainerVC.h"
#import "HqSubContainerVC.h"


@interface HqContainerVC ()<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,assign) NSUInteger page;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,strong) HqSubContainerVC *subContainerVC;

@end

@implementation HqContainerVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐作者";
    self.datas = [[NSMutableArray alloc] init];
    [self.datas addObjectsFromArray:@[@"1",@"2"]];
    self.page = 1;
    self.canScroll = YES;
    
    [self  initView];
}
- (void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
}
- (HqSubContainerVC *)subContainerVC{
    if (!_subContainerVC) {
        _subContainerVC = [[HqSubContainerVC alloc] init];
    }
    return _subContainerVC;
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
- (HqTableView *)tableView{
    if (!_tableView) {
        _tableView = [[HqTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }
    return SCREEN_HEIGHT-64;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *cellIdentifer = @"UITableViewCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        }
        cell.backgroundColor = [UIColor purpleColor];
        cell.textLabel.text = @"iiiiii";
        return cell;
    }
    
    static NSString *cellIdentifer = @"UITableViewCell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!_subContainerVC) {
        [self addChildViewController:self.subContainerVC];
        [cell addSubview:self.subContainerVC.view];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y>=100 || self.canScroll==NO) {
        scrollView.contentOffset = CGPointMake(0, 100);
        self.canScroll = NO;
        self.subContainerVC.canScroll = YES;
    }
}

@end


