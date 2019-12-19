//
//  HqChatManage.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatManage.h"

@interface HqChatManage ()<JMessageDelegate,JMSGConversationDelegate>

@end

#define  JMAppKey @"0b493dd2899aa6b2399f1ae0"
@implementation HqChatManage

- (void)dealloc{
    [JMessage removeAllDelegates];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [JMessage addDelegate:self withConversation:nil];
    }
    return self;
}
+ (void)hqRegisterJMWithLaunchOptions:(NSDictionary *)launchOptions{
    //启动 JMessage SDK
//    [JMessage setDebugMode] ;
    [JMessage setupJMessage:launchOptions appKey:JMAppKey channel:nil apsForProduction:NO category:nil messageRoaming:NO];
}
//用户注册
+ (void)hqUserRegisterIMWithUsername:(NSString *)username password:(NSString *)password handler:(JMSGCompletionHandler)handler{
    [JMSGUser registerWithUsername:username password:password completionHandler:handler];
}
//用户登录
+ (void)hqUserLoginIMWithUsername:(NSString *)username password:(NSString *)password handler:(JMSGCompletionHandler)handler{
    [JMSGUser loginWithUsername:username password:password completionHandler:handler];
}
//更新用户信息
+ (void)hqUpdteUserInfo:(NSDictionary *)userInfo handler:(JMSGCompletionHandler)handler{
    JMSGUserInfo *jmUseInfo = [[JMSGUserInfo alloc] init];
    NSData *avatarData = [userInfo hq_objectForKey:@"avatar"];
    NSString *nickname = [userInfo hq_objectForKey:@"nickname"];
    if (avatarData) {
        jmUseInfo.avatarData = avatarData;
    }
    if (nickname.length>0) {
        jmUseInfo.nickname = nickname;
    }
    [JMSGUser updateMyInfoWithUserInfo:jmUseInfo completionHandler:handler];
}
//用户退出登录
+ (void)hqUserLogoutIMWithHandler:(JMSGCompletionHandler)handler{
    [JMSGUser logout:handler];
}

//获取聊天室列表
+ (void)hqGetChatRoomListWithPage:(NSInteger)page handler:(JMSGCompletionHandler)handler{
    [JMSGChatRoom getChatRoomListWithAppKey:nil start:page count:20 completionHandler:handler];
}
//获取聊天室详情
+ (void)hqGetChatRoomInfosWithRoomIds:(NSArray *)roomIds handler:(JMSGCompletionHandler)handler{
    [JMSGChatRoom getChatRoomInfosWithRoomIds:roomIds completionHandler:handler];
}
//进入聊天室内
- (void)hqEnterChatRoomWithRoomId:(NSString *)roomId handler:(JMSGCompletionHandler)handler{
    [JMSGChatRoom enterChatRoomWithRoomId:roomId completionHandler:handler];
}
//离开聊天室
- (void)hqLeaveChatRoomWithRoomId:(NSString *)roomId handler:(JMSGCompletionHandler)handler{
    [JMSGChatRoom leaveChatRoomWithRoomId:roomId completionHandler:handler];
}
//聊天室禁言列表
- (void)hqChatRoom:(JMSGChatRoom *)chatRoom getChatRoomSilencesWithStart:(NSInteger)start handler:(void(^)(NSArray <__kindof JMSGMemberSilenceInfo *>*JMSG_NULLABLE list,SInt64 total,NSError *JMSG_NULLABLE error))handler{
    [chatRoom getChatRoomSilencesWithStart:start count:10 handler:handler];
}
//设置聊天室成员禁言 silenceTime 毫秒数
- (void)hqChatRoom:(JMSGChatRoom *)chatRoom AddMemberSilenceWithTime:(SInt64)silenceTime usernames:(NSArray *)usernames handler:(JMSGCompletionHandler)handler{
    [chatRoom  addChatRoomSilenceWithTime:silenceTime usernames:usernames appKey:nil handler:handler];
}
//移除聊天室成员禁言
- (void)hqChatRoom:(JMSGChatRoom *)chatRoom removeMemberSilenceUsernames:(NSArray *)usernames handler:(JMSGCompletionHandler)handler{
    [chatRoom deleteChatRoomSilenceWithUsernames:usernames appKey:nil handler:handler];
}
//获取聊天室成员禁言状态
- (void)hqChatRoom:(JMSGChatRoom *)chatRoom getChatRoomMemberSilenceWithUsername:(NSString *)username handler:(JMSGCompletionHandler)handler{
    [chatRoom getChatRoomMemberSilenceWithUsername:username appKey:nil handler:handler];
}

//发送文本消息
- (void)hqSendTextMessage:(id)message roomId:(NSString *)roomId{
    JMSGCustomContent *custom;
    JMSGTextContent *textContent = [[JMSGTextContent alloc] initWithText:message];
    JMSGMessage *msg = [JMSGMessage createChatRoomMessageWithContent:textContent chatRoomId:roomId];
    [JMSGMessage sendMessage:msg];
}

//发送图片消息
- (void)hqSendImageMessage:(id)message roomId:(NSString *)roomId{
    JMSGImageContent*imageContent = [[JMSGImageContent alloc] initWithImageData:message];
    imageContent.format = @"jpg";
    JMSGMessage *msg = [JMSGMessage createChatRoomMessageWithContent:imageContent chatRoomId:roomId];
    [JMSGMessage sendMessage:msg];
}

#pragma mark - JMessageDelegate
//发送消息后结果
- (void)onSendMessageResponse:(JMSGMessage *)message error:(NSError *)error{
    NSLog(@"发送消息回调--%@,error--%@",message,error);
    if (error == nil) {
        [Dialog toastCenter:@"发送成功"];
    }
}
//接收消息
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error{
    NSLog(@"接收消息回调--%@,error--%@",message,error);

}

#pragma mark - JMSGConversationDelegate
//接收聊天室消息
- (void)onReceiveChatRoomConversation:(JMSGConversation *)conversation messages:(NSArray<__kindof JMSGMessage *> *)messages{
    JMSGMessage *jMsg = messages.lastObject;
   
    NSLog(@"接收聊天室消息回调--%@,messages--%@",conversation,jMsg);
    NSLog(@"接收聊天室消息回调--%@,messages--%@",conversation,jMsg.content);
    NSLog(@"msg.content.toJsonString===%@",jMsg.content.toJsonString);

    [self dealReceiveMessage:messages];
}
- (void)dealReceiveMessage:(NSArray *)messages{
    if (messages.count>0) {
        NSMutableArray *hqMsgs = [[NSMutableArray alloc] init];
        for (JMSGMessage *jMsg in messages) {
            HqChatMessage *hqMsg = [[HqChatMessage alloc] init];
            JMSGUser *fromUser = jMsg.fromUser;
            hqMsg.nickname = fromUser.nickname;
            hqMsg.userId = @(fromUser.uid).stringValue;
            hqMsg.userAvatar = fromUser.avatar;
            BOOL isMe = [fromUser isEqualToUser:self.loginUser];
            if (isMe) {
                hqMsg.messageType = HqChatMessageFromMe;
            }else{
                hqMsg.messageType = HqChatMessageFromOther;
            }
            [self dealMessageTypeWithJMsg:jMsg hqMessage:hqMsg];
            [hqMsgs addObject:hqMsg];
        }
        if ([self.delegate respondsToSelector:@selector(hqChatManageOnReceviedMessages:)] && self.delegate) {
            [self.delegate hqChatManageOnReceviedMessages:hqMsgs];
        }
        
    }
}
- (void)dealMessageTypeWithJMsg:(JMSGMessage *)jMsg hqMessage:(HqChatMessage *)hqMsg{
    switch (jMsg.contentType) {
        case kJMSGContentTypeText:
        {
            JMSGTextContent *textContent = (JMSGTextContent *)jMsg.content;
            hqMsg.messageType = HqChatMessageTypeText;
            NSLog(@"文本消息==%@",textContent.text);
            hqMsg.content = textContent.text;
        }
            break;
        case kJMSGContentTypeImage:
        {
            JMSGImageContent *imageContent = (JMSGImageContent *)jMsg.content;
            NSLog(@"图片消息链接==%@",imageContent.imageLink);
            hqMsg.messageType = HqChatMessageTypeImage;
            NSLog(@"图片大小==%@",NSStringFromCGSize(imageContent.imageSize));
            hqMsg.imageUrl = imageContent.imageLink;
            hqMsg.imageSize = imageContent.imageSize;

        }
            break;
            default:
            break;
    }
}
@end
