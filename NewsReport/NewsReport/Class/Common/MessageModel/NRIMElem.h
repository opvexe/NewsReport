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
@property (nonatomic,assign) BOOL isSender;

/*!
 *  是否已读
 */
@property (nonatomic,assign) BOOL isRead;
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
@property (nonatomic,assign) MessageSendState status;
/**
 *  消息拥有者
 */
@property (nonatomic,assign) MessageOwner direction;

/** 缓存数据模型对应的cell的高度，只需要计算一次并赋值，以后就无需计算了 **/
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGFloat contentHeight;
@property (nonatomic,assign) CGFloat contentWidth;
@end



