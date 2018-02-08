//
//  NRIMElem.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRChatUserProtocol.h"
#import "NRTessageProtocol.h"
#import "NRUser.h"


/**
 *  录音视频状态
 */
typedef NS_ENUM(NSInteger, VoiceMessageStatus) {
    VoiceMessageStatusNormal,
    VoiceMessageStatusRecording,
    VoiceMessageStatusPlaying,
};

/**
 *  消息拥有者类型
 */
typedef NS_ENUM(NSUInteger, MessageOwner)
{
    MessageOwnerUnknown = 0, /**< 未知的消息拥有者 */
    MessageOwnerSystem,      /**< 系统消息 */
    MessageOwnerSelf,        /**< 自己发送的消息 */
    MessageOwnerOther,       /**< 接收到的他人消息 */
};

/**
 *  消息所有者类型
 */
typedef NS_ENUM(NSInteger, PartnerType){
    PartnerTypeUser,          // 用户
    PartnerTypeGroup,         // 群聊
};

/**
 *  消息发送状态,自己发送的消息时有
 */
typedef NS_ENUM(NSUInteger, MessageSendState)
{
    MessageSendSuccess = 0,  /**< 消息发送成功 */
    MessageSendStateSending, /**< 消息发送中 */
    MessageSendFail,         /**< 消息发送失败 */
};

/**
 *   消息读取状态
 */
typedef NS_ENUM(NSUInteger, MessageReadState)
{
    MessageUnRead = 0, /**< 消息未读 */
    MessageReading,   /**< 正在接收 */
    MessageReaded,     /**< 消息已读 */
};


@interface NRMessage : NSObject<NRTessageProtocol>

@property (nonatomic, strong) NSString *messageID;                  // 消息ID
@property (nonatomic, strong) NSString *userID;                     // 发送者ID
@property (nonatomic, strong) NSString *friendID;                   // 接收者ID
@property (nonatomic, strong) NSString *groupID;                    // 讨论组ID（无则为nil）
@property (nonatomic, strong) NSDate *date;                         // 发送时间

@property (nonatomic, assign) BOOL showTime;
@property (nonatomic, assign) BOOL showName;

@property (nonatomic, strong) id<NRChatUserProtocol> fromUser;      // 发送者

@property (nonatomic, assign) PartnerType partnerType;            // 对方类型(用户，群聊)
@property (nonatomic, assign) MessageType messageType;            // 消息类型(文本，图片)
@property (nonatomic,assign)  MessageSendState  messageStatus;    // 发送状态
@property (nonatomic, assign) MessageReadState readStatus;        // 读取状态
@property (nonatomic, assign) MessageOwner ownerTyper;            // 发送者类型(自己，他人)

@property (nonatomic, strong) NSMutableDictionary *content;

+ (NRMessage *)createMessageByType:(MessageType)type;


/** 缓存数据模型对应的cell的高度，只需要计算一次并赋值，以后就无需计算了 **/
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGFloat contentHeight;
@property (nonatomic,assign) CGFloat contentWidth;


@end



