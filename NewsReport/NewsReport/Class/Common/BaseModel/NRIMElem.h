//
//  NRIMElem.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRIMUserModel.h"
@interface NRIMElem : NSObject

/*!
 *  消息的唯一标识符
 */
@property (nonatomic, copy) NSString *messageId;

/*!
 *  发送方
 */
@property (nonatomic, copy) NSString *from;

/*!
 * 消息内容中携带的发送者的用户信息
 *
 */
@property(nonatomic, strong) NRIMUserModel *senderUserInfo;

/**
 *  是否发送方
 *
 *  @return TRUE 表示是发送消息    FALSE 表示是接收消息
 */
@property (nonatomic) BOOL isSender;

/**
 *  当前消息的时间戳
 */
@property(nonatomic,copy)NSString *timestamp;

/**
 *  消息类型（文本，图片）
 */
@property (nonatomic,assign) MessageType messageType;

/**
 *  消息聊天类型(单聊，群聊)
 */
@property (nonatomic,assign) MessageChat messageChatType;

/*!
 *  消息状态
 */
@property (nonatomic) MessageSendState status;


- (instancetype)initWithMessage:(NRIMElem *)message;
@end


/**
 *  文本消息Elem
 */

@interface NRIMTextElem : NRIMElem

/**
 *  消息文本
 */
@property(nonatomic,copy) NSString *text;

@end


/**
 *  图片消息Elem
 */
@interface NRIMImageElem : NRIMElem


@end

/**
 *  语音消息Elem
 */
@interface NRIMSoundElem : NRIMElem

/**
 *  语音长度（秒），发送消息时设置
 */
@property(nonatomic,assign) int second;

/**
 *  语音数据大小
 */
@property(nonatomic,assign) int dataSize;

/**
 *  语音文件的路径，接收时使用getSound获得数据
 */
@property(nonatomic,strong) NSString * path;

@end


/**
 *  文件消息Elem
 */
@interface NRIMFileElem : NRIMElem

/**
 *  文件大小
 */
@property(nonatomic,assign) int fileSize;

/**
 *  文件显示名，发消息时设置
 */
@property(nonatomic,strong) NSString * filename;

/**
 *  文件的路径（设置path时，优先上传文件）
 */
@property(nonatomic,strong) NSString * path;

@end

