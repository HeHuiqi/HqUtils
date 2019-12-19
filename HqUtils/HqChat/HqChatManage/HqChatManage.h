//
//  HqChatManage.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
//自己的消息模型
#import "HqChatMessage.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HqChatManageDelegate;
@interface HqChatManage : NSObject

@property(nonatomic,weak) id<HqChatManageDelegate> delegate;
//登录的用户
@property(nonatomic,strong) JMSGUser *loginUser;//当前登录的用户

//启动IM——SDK
+ (void)hqRegisterJMWithLaunchOptions:(NSDictionary *)launchOptions;

#pragma mark 用户相关
//用户注册
+ (void)hqUserRegisterIMWithUsername:(NSString *)username password:(NSString *)password handler:(JMSGCompletionHandler)handler;
//更新用户信息
+ (void)hqUpdteUserInfo:(NSDictionary *)userInfo handler:(JMSGCompletionHandler)handler;
//用户登录
+ (void)hqUserLoginIMWithUsername:(NSString *)username password:(NSString *)password handler:(JMSGCompletionHandler)handler;
//用户退出登录
+ (void)hqUserLogoutIMWithHandler:(JMSGCompletionHandler)handler;

#pragma mark 聊天室

//获取聊天室列表
+ (void)hqGetChatRoomListWithPage:(NSInteger)page handler:(JMSGCompletionHandler)handler;
//获取聊天室详情
+ (void)hqGetChatRoomInfosWithRoomIds:(NSArray *)roomIds handler:(JMSGCompletionHandler)handler;
//进入聊天室内
- (void)hqEnterChatRoomWithRoomId:(NSString *)roomId handler:(JMSGCompletionHandler)handler;
//离开聊天室
- (void)hqLeaveChatRoomWithRoomId:(NSString *)roomId handler:(JMSGCompletionHandler)handler;
//聊天室禁言列表
- (void)hqChatRoom:(JMSGChatRoom *)chatRoom getChatRoomSilencesWithStart:(NSInteger)start handler:(void(^)(NSArray <__kindof JMSGMemberSilenceInfo *>*JMSG_NULLABLE list,SInt64 total,NSError *JMSG_NULLABLE error))handler;
//设置聊天室成员禁言 silenceTime 毫秒数
- (void)hqChatRoom:(JMSGChatRoom *)chatRoom AddMemberSilenceWithTime:(SInt64)silenceTime usernames:(NSArray *)usernames handler:(JMSGCompletionHandler)handler;
//移除聊天室成员禁言
- (void)hqChatRoom:(JMSGChatRoom *)chatRoom removeMemberSilenceUsernames:(NSArray *)usernames handler:(JMSGCompletionHandler)handler;
//获取聊天室成员禁言状态
- (void)hqChatRoom:(JMSGChatRoom *)chatRoom getChatRoomMemberSilenceWithUsername:(NSString *)username handler:(JMSGCompletionHandler)handler;


#pragma mark 发消息

//发送文本消息
- (void)hqSendTextMessage:(id)message roomId:(NSString *)roomId;
//发送图片消息
- (void)hqSendImageMessage:(id)message roomId:(NSString *)roomId;

@end

@protocol HqChatManageDelegate <NSObject>

@optional
- (void)hqChatManageOnReceviedMessages:(NSArray *)messages;

@end

NS_ASSUME_NONNULL_END
