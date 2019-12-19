//
//  HqChatRoomListVC.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatRoomListVC.h"
#import "HqChatManage.h"
#import "HqChatVC.h"
@interface HqChatRoomListVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,assign) NSUInteger page;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,strong) UITextField *userIdTf;
@property(nonatomic,strong) JMSGUser *loginUser;



@end

@implementation HqChatRoomListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天室列表";
    self.datas = [[NSMutableArray alloc] init];
    self.page = 1;
    
    [self  initView];
    [self getChatRoomList];
}
- (void)getChatRoomList{
    NSString *userId = self.userIdTf.text;
    if (userId.length>0) {
    //    [self goRegisterIMWithUserId:userId];
    [self goLoginIMWithUserId:userId];

    }

}
- (void)goRegisterIMWithUserId:(NSString *)userId{
    [HqChatManage hqUserRegisterIMWithUsername:userId password:userId handler:^(id resultObject, NSError *error) {
        NSLog(@"注册---resultObject==%@",resultObject);
        if (resultObject==nil) {
            [self goLoginIMWithUserId:userId];
        }else{
            self.loginUser = resultObject;
            [self getRoomList];
        }
    }];
}
- (void)dealloc{
    [self userlogout];
}
- (void)userlogout{
    [HqChatManage hqUserLogoutIMWithHandler:^(id resultObject, NSError *error) {
        NSLog(@"退出登录---resultObject==%@",resultObject);

    }];
}
- (void)goLoginIMWithUserId:(NSString *)userId{
    [HqChatManage hqUserLoginIMWithUsername:userId password:userId handler:^(id resultObject, NSError *error) {
         NSLog(@"登录---resultObject==%@",resultObject);
        if (resultObject !=nil) {
            self.loginUser = resultObject;
            [self getRoomList];
        }
     }];
}
- (void)getRoomList{
    [HqChatManage hqGetChatRoomListWithPage:0 handler:^(id resultObject, NSError *error) {
        NSLog(@"聊天室列表--resultObject==%@",resultObject);
        NSArray *list = resultObject;
        [self.datas removeAllObjects];
        [self.datas addObjectsFromArray:list];
        [self.tableView reloadData];
    }];
}
- (void)initView{
    

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.navBarHeight);
        make.left.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(0);
    }];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    header.backgroundColor = [UIColor whiteColor];
    [header addSubview:self.userIdTf];
    self.tableView.tableHeaderView = header;
    
}
- (UITextField *)userIdTf{
    if (!_userIdTf) {
        _userIdTf = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, 30)];
        _userIdTf.delegate = self;
        _userIdTf.placeholder = @"输入账号";
        _userIdTf.text = @"012345";
        _userIdTf.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _userIdTf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _userIdTf;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
    JMSGChatRoom *chatRoom = self.datas[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"聊天室=%@，名字=%@",chatRoom.roomID,chatRoom.name];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JMSGChatRoom *chatRoom = self.datas[indexPath.row];
    HqChatVC *chatVC = [[HqChatVC alloc] init];
    chatVC.loginUser = self.loginUser;
    chatVC.chatRoom = chatRoom;
    Push(chatVC);
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.text) {
        [self getChatRoomList];
    }
    return YES;
}
#pragma mark - 请求

- (void)refreshData{
    self.page = 1;
    [self requsetFollowData];
    
}
- (void)loadData{
    self.page++;
    [self requsetFollowData];
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

