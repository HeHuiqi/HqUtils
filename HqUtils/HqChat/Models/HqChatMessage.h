//
//  HqChatMessage.h
//  HqUtils
//
//  Created by hehuiqi on 2019/12/11.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <Foundation/Foundation.h>
//消息类型
typedef NS_ENUM(NSInteger,HqChatMessageType) {
    HqChatMessageTypeText=1,//文本
    HqChatMessageTypeImage,//图片
    HqChatMessageTypeNotify,//通知消息
};
//消息发送方
typedef NS_ENUM(NSInteger,HqChatMessageFrom) {
    HqChatMessageFromMe=1,//自己
    HqChatMessageFromOther,//他人
};

NS_ASSUME_NONNULL_BEGIN

@interface HqChatMessage : NSObject

@property(nonatomic,assign) BOOL selected;

@property(nonatomic,assign) HqChatMessageFrom messageFrom;
@property(nonatomic,assign) HqChatMessageType messageType;

@property(nonatomic,copy) NSString *userId;
@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *userAvatar;

//文本
@property(nonatomic,copy) NSString *content;

//图片
@property(nonatomic,copy) NSString *imageUrl;//本地或者网络路径
@property(nonatomic,assign) CGSize imageSize;
@property(nonatomic,strong) UIImage *localImage;//本地图片





@end

NS_ASSUME_NONNULL_END
