//
//  HqCodeVC.m
//  HqUtils
//
//  Created by hehuiqi on 6/21/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCodeVC.h"
#import "HqLoopScrollVIew.h"
#import "HqLoopView.h"


@interface HqCodeVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSUInteger page;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *datas;


@end

@implementation HqCodeVC

- (void)viewDidLoad{
    [super viewDidLoad];
//    [self currentVC];
//    [self testTabView];
    [self testLoopView];

    
}
- (void)testBlock{
    int (^Multipy)(int,int) = ^(int a, int b){
        return a*b;
    };
    int result = Multipy(2,3);
    NSLog(@"result==%@",@(result));
}
- (void)testHook{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    [btn setTitle:@"去登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn  addTarget:self action:@selector(goLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)goLogin:(UIButton *)btn{
    NSLog(@"btttt==");
}
- (id)currentVC{
    UIWindow *currentWindow = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootVC = currentWindow.rootViewController;
    
    UIViewController * _Nullable (^HqNavTopVC)(UIViewController *) = ^(UIViewController *vc) {
        UIViewController *topVC = nil;
        if ([vc isKindOfClass:UINavigationController.class]) {
            NSArray *vcs = vc.childViewControllers;
            if (vcs.count>0) {
                NSInteger preIndex = (vcs.count-2);
                preIndex = preIndex<=0 ? 0:preIndex;
               UIViewController *topVC  = vcs[preIndex];
                NSLog(@"vc==%@,title=%@",topVC.class,topVC.title);
            }
        }
        return topVC;
    };
    
    if (rootVC) {
        if ([rootVC isKindOfClass:UITabBarController.class]) {
            UITabBarController *tabVC = (UITabBarController *)rootVC;
            UIViewController *selectedVC = tabVC.selectedViewController;
            return HqNavTopVC(selectedVC);
        }
        if ([rootVC isKindOfClass:UINavigationController.class]) {
            return HqNavTopVC(rootVC);
        }
    }
    return nil;

}
- (void)testHqLoop{
    HqLoopView *hqLoopView = [[HqLoopView alloc] initWithFrame:CGRectMake(20, 100, 300, 200)];
    hqLoopView.loopViewType = HqLoopViewTypePlain;
    [self.view addSubview:hqLoopView];
    hqLoopView.backgroundColor = [UIColor blackColor];
    [hqLoopView testData];
}
- (void)testLoopView{
    HqLoopScrollVIew *hqLoopView = [[HqLoopScrollVIew alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40, 200)];
    hqLoopView.loop = YES;
    [self.view addSubview:hqLoopView];
    hqLoopView.backgroundColor = [UIColor blackColor];
    [hqLoopView testData];
}
- (void)dealloc{
    NSLog(@"dealloc");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}
- (void)initView{
    
}
- (void)testTabView{
    self.datas = @[].mutableCopy;
    for (int i = 0; i<20; i++) {
        [self.datas addObject:@""];
    }
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight = 100;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    header.backgroundColor = HqRandomColor;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"HqNewTopicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{


}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (!decelerate) {
        NSLog(@"---");
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
}
#pragma mark - 请求
- (void)refreshData{
    self.page = 1;
}
- (void)loadData{
    self.page++;
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

