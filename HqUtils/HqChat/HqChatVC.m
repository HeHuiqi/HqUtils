//
//  HqChatVC.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatVC.h"

//cell
#import "HqChatNotifyCell.h"

#import "HqChatMeTextCell.h"
#import "HqChatOtherTextCell.h"

#import "HqChatMeImageCell.h"
#import "HqChatOtherImageCell.h"


#import "HqChatInputView.h"
//
#import "HqChatManage.h"

@interface HqChatVC ()<UITableViewDelegate,UITableViewDataSource,
HqChatInputViewDelegate,HqChatManageDelegate,
HqChatBaseCellDelegate>

@property(nonatomic,assign) NSUInteger page;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *datas;
@property(nonatomic,strong) HqChatInputView *chatInputView;
@property(nonatomic,strong) HqChatManage *chatManage;

@end

@implementation HqChatVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天";
    self.datas = [[NSMutableArray alloc] init];
    self.page = 1;

//    for (int i = 0; i<2; i++) {
//        HqChatMessage *msg = [[HqChatMessage alloc] init];
//        msg.nickname = @"昵称昵称";
//        msg.messageFrom = HqChatMessageFromOther;
//        msg.content = [@"是电光火石看到过很多苦噶伤感的速度换" stringByAppendingString:@(i).stringValue];
////        msg.content = @"是";
//
//        msg.messageType = HqChatMessageTypeText;
//        msg.messageFrom = HqChatMessageFromOther;
//        if (i %2 == 1) {
//            msg.messageFrom = HqChatMessageFromMe;
//        }
//        if (i ==5 ) {
//            msg.content = @"一条通知消息";
//            msg.messageType = HqChatMessageTypeNotify;
//        }
//        [self.datas addObject:msg];
//    }
    
    [self  initView];
    
    [self enterChatRoom];
    
    [HqChatManage hqUpdteUserInfo:@{@"nickname":@"h012345"} handler:^(id resultObject, NSError *error) {
        
    }];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self leaveChatRoomWithHandler:nil];
}
- (void)leaveChatRoomWithHandler:(JMSGCompletionHandler)handler{

    [self.chatManage hqLeaveChatRoomWithRoomId:self.chatRoom.roomID handler:^(id resultObject, NSError *error) {
        NSLog(@"离开聊天室--%@",resultObject);
        NSLog(@"离开聊天室--error%@",error);
        if(handler){
            handler(resultObject,error);
        }
     }];
}
- (void)enterChatRoom{
    if (self.chatRoom) {
        
        [self.chatManage hqEnterChatRoomWithRoomId:self.chatRoom.roomID handler:^(id resultObject, NSError *error) {
            NSLog(@"进入聊天室--%@",resultObject);
            NSLog(@"进入聊天室--error%@",error);
            
            if (resultObject) {
                JMSGConversation *chatRootmConversation = resultObject;
                [chatRootmConversation allMessages:^(id resultObject, NSError *error) {
                    NSLog(@"聊天室消息列表==%@",resultObject);
                }];
            }else{
                if (error.code == 851003) {
                    [self leaveChatRoomWithHandler:^(id resultObject, NSError *error) {
                        [self enterChatRoom];
                    }];
                }
            }
        }];
    }
}

- (HqChatManage *)chatManage{
    if (!_chatManage) {
        _chatManage = [[HqChatManage alloc] init];
        _chatManage.loginUser = self.loginUser;
        _chatManage.delegate = self;
    }
    return _chatManage;
}
- (void)initView{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatInputView];
}
- (HqChatInputView *)chatInputView{
    if (!_chatInputView) {
        CGFloat y = SCREEN_HEIGHT - 50;
        CGRect rect = CGRectMake(0, y, SCREEN_WIDTH, 350);

        _chatInputView = [[HqChatInputView alloc] initWithFrame:rect];
        _chatInputView.delegate = self;
    }
    return _chatInputView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat height = SCREEN_HEIGHT - self.navBarHeight-50;
        CGRect rect = CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, height);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.estimatedRowHeight = SCREEN_WIDTH+80;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HqChatMessage *messge = self.datas[indexPath.row];
    if (messge.messageType == HqChatMessageTypeNotify) {
        static NSString *cellIdentifer = @"HqChatNotifyCell";
        HqChatNotifyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
        if (!cell) {
            cell = [[HqChatNotifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        }
        cell.message = self.datas[indexPath.row];
        return cell;
    }else{
        if (messge.messageFrom == HqChatMessageFromMe) {
            return [self configMessageCellFromMeWithTableView:tableView hqMessage:messge];
        }else{
            return [self configMessageCellFromOtherWithTableView:tableView hqMessage:messge];
        }
    }
}
- (UITableViewCell *)configMessageCellFromMeWithTableView:(UITableView *)tableView hqMessage:(HqChatMessage *)message{
    switch (message.messageType) {
        case HqChatMessageTypeText:
        {
            static NSString *cellIdentifer = @"HqChatMeTextCell";
            HqChatMeTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
            if (!cell) {
                cell = [[HqChatMeTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
            }
            cell.delegate = self;
            cell.message = message;
            return cell;
        }
            break;
            case HqChatMessageTypeImage:
            {
                static NSString *cellIdentifer = @"HqChatMeImageCell";
                HqChatMeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
                if (!cell) {
                    cell = [[HqChatMeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
                }
                cell.delegate = self;
                cell.message = message;
                return cell;
            }
                break;
            
        default:
            break;
    }
    return nil;
}
- (UITableViewCell *)configMessageCellFromOtherWithTableView:(UITableView *)tableView hqMessage:(HqChatMessage *)message{
    switch (message.messageType) {
        case HqChatMessageTypeText:
        {
            static NSString *cellIdentifer = @"HqChatOtherTextCell";
            HqChatOtherTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
            if (!cell) {
                cell = [[HqChatOtherTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
            }
            cell.message = message;
            cell.delegate = self;
            return cell;
        }
            break;
        case HqChatMessageTypeImage:
        {
            static NSString *cellIdentifer = @"HqChatOtherImageCell";
            HqChatOtherImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
            if (!cell) {
                cell = [[HqChatOtherImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
            }
            cell.delegate = self;
            cell.message = message;
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.chatInputView mTextViewResignFirstResponder];
}

#pragma mark - HqChatInputViewDelegate
- (void)hqChatInputViewKeyBoardHeight:(CGFloat)keyBoardHeight changeTime:(CGFloat)changeTime{
    
    [UIView animateWithDuration:changeTime animations:^{
        CGFloat inputY = SCREEN_HEIGHT - 50 - keyBoardHeight;
         CGFloat tableHeight = SCREEN_HEIGHT - 50 - keyBoardHeight-self.navBarHeight;
        self.tableView.frame = CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, tableHeight);
        self.chatInputView.frame = CGRectMake(0, inputY, SCREEN_WIDTH, 350);
        [self tableViewScrollToBottomWithAnimated:NO];
    }];
}
- (void)hqChatInputViewDidSendTextMessage:(NSString *)text{

    [self sendTextMessage:text];
    [self tableViewScrollToBottomWithAnimated:YES];
}
//点击更多后的动作
- (void)hqChatInputViewDidClickItem:(HqListItemModel *)item{
    switch (item.tag) {
        case 0:
        {
            //图片
            UIImage *image = [UIImage imageNamed:@"lc.jpg"];
            [self sendImageMessage:image];
            [self tableViewScrollToBottomWithAnimated:YES];
        }
            break;
            
        case 1:
        {
            //红包
        }
            break;
            
        default:
            break;
    }
}
- (void)sendTextMessage:(NSString *)text{
    HqChatMessage *msg = [[HqChatMessage alloc] init];
    msg.nickname = @"我";
    msg.content = text;
    msg.messageFrom = HqChatMessageFromMe;
    msg.messageType = HqChatMessageTypeText;
    [self.datas addObject:msg];
    [self.tableView reloadData];
    [self.chatManage hqSendTextMessage:text roomId:self.chatRoom.roomID];
}
- (void)sendImageMessage:(UIImage *)image{
    HqChatMessage *msg = [[HqChatMessage alloc] init];
    msg.nickname = @"我";
    msg.localImage = image;
    msg.messageFrom = HqChatMessageFromMe;
    msg.messageType = HqChatMessageTypeImage;
    [self.datas addObject:msg];
    [self.tableView reloadData];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    [self.chatManage hqSendImageMessage:imageData roomId:self.chatRoom.roomID];
}
- (void)tableViewScrollToBottomWithAnimated:(BOOL)animated{
    if (self.datas.count>0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.datas.count-1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionBottom) animated:animated];
        });
    }

}
#pragma mark - HqChatManageDelegate
- (void)hqChatManageOnReceviedMessages:(NSArray *)messages{
    [self.datas addObjectsFromArray:messages];
    [self.tableView reloadData];
    [self tableViewScrollToBottomWithAnimated:YES];

}

#pragma mark - HqChatBaseCellDelegate
//点击图片
- (void)HqChatBaseCellOnClickImageCell:(HqChatBaseCell *)cell{
    NSLog(@"点击图片");
    [self.chatInputView mTextViewResignFirstResponder];
}
- (void)HqChatBaseCellOnLongPressCell:(HqChatBaseCell *)cell{
    if ([self.chatInputView.mTextView isFirstResponder]) {
        self.chatInputView.mTextView.hqNextResponder = cell;
        [cell showOptMenuIsNeedBecomFirstResponser:NO];
    }else{
        [cell showOptMenuIsNeedBecomFirstResponser:YES];
    }

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

