//
//  NRIMElem.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRUser.h"

@interface NRMessage : NSObject

/*!
 *  消息的唯一标识符
 */
@property (nonatomic, copy) NSString *messageId;

/*!
 *  发送方
 */
@property (nonatomic, copy) NSString *from;

/*!
 *  接收方
 */
@property (nonatomic, copy) NSString *to;

/*!
 * 消息拥有者用户信息
 *
 */
@property(nonatomic, strong) NRUser *senderUserInfo;

/**
 *  是否发送方
 *
 *  @return TRUE 表示是发送消息    FALSE 表示是接收消息
 */
@property (nonatomic,assign) BOOL isSender;

/*!
 *  是否已读
 */
@property (nonatomic,assign) BOOL isMessageRead;

//多媒体消息：是否正在播放
@property (nonatomic,assign) BOOL isMediaPlaying;
//多媒体消息：是否播放过
@property (nonatomic,assign) BOOL isMediaPlayed;

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
@property (nonatomic,assign) ConversationType messageChatType;

/*!
 *  消息状态
 */
@property (nonatomic,assign) MessageSendState  messageStatus;
/**
 *  消息拥有者
 */
@property (nonatomic,assign) MessageOwner direction;





/**
 *  原图(图片，视频封面)
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  缩略图
 */
@property (strong, nonatomic) UIImage *thumbnailImage;

/**
 *  缩略图尺寸
 */
@property (nonatomic,assign) CGSize thumbnailImageSize;






/**
 *  语音长度（秒），发送消息时设置
 */
@property(nonatomic,assign) int second;

/**
 *  语音数据大小
 */
@property(nonatomic,assign) int dataSize;






/**
 *  文件大小
 */
@property(nonatomic,assign) float fileSize;

/**
 *  文件显示名，发消息时设置
 */
@property(nonatomic,strong) NSString * filename;






/** 缓存数据模型对应的cell的高度，只需要计算一次并赋值，以后就无需计算了 **/
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGFloat contentHeight;
@property (nonatomic,assign) CGFloat contentWidth;


@end



