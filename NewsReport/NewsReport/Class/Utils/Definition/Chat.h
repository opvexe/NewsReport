//
//  Chat.h
//  NewsReport
//
//  Created by Facebook on 2018/1/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef Chat_h
#define Chat_h

/**
 *  会话提示类型
 */
typedef NS_ENUM(NSInteger, ClueType) {
    ClueTypeNone,
    ClueTypePoint,
    ClueTypePointWithNumber,
};

/**
 *  会话类型(1开头为单聊，2开头为群聊)
 */
typedef NS_ENUM(NSUInteger, ConversationType)
{
    ConversationTypeSingle = 0, /**< 单人聊天,不显示nickname */
    ConversationTypeGroup,      /**< 群组聊天,显示nickname */
    ConversationTypePublic,       // 公众号
    ConversationTypeServerGroup,  // 服务组（订阅号、企业号）
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
 *  消息类型
 */
typedef NS_ENUM(NSUInteger, MessageType)
{
    MessageTypeUnknow , /**< 未知的消息类型 */
    MessageTypeDateTime ,  /**< 消息发生的日期时间Cell */
    MessageTypeText = 11,       /**< 文本消息 */
    MessageTypeImage,      /**< 图片消息 */
    MessageTypeGifImage,   /**< Gif动画图片消息 */
    MessageTypeVideo,      /**< 视频消息 */
    MessageTypeVoice,      /**< 语音消息 */
    MessageTypeFile,       /**< 文件消息 */
    MessageTypeLocation,   /**< 地理位置消息 */
    MessageTypeVoiceCall,  /**< 音频呼叫 */
    MessageTypeVideoCall,  /**< 视频呼叫 */
};



/**
 *  消息读取状态,接收的消息时有
 */
typedef NS_ENUM(NSUInteger, MessageReadState)
{
    MessageUnRead = 0, /**< 消息未读 */
    MessageReading,   /**< 正在接收 */
    MessageReaded,     /**< 消息已读 */
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



/*!
 通话媒体类型
 */
typedef NS_ENUM(NSInteger, CallMediaType) {
    /*!
     音频
     */
    CallMediaAudio = 1,
    /*!
     视频
     */
    CallMediaVideo = 2,
};




/*!
 通话状态
 */
typedef NS_ENUM(NSInteger, CallStatus) {
    /*!
     初始状态
     */
    //    XLCallIdle   = 0,
    /*!
     正在呼出
     */
    CallDialing = 1,
    /*!
     正在呼入
     */
    CallIncoming = 2,
    /*!
     收到一个通话呼入后，正在振铃
     */
    CallRinging = 3,
    /*!
     正在通话
     */
    CallActive = 4,
    /*!
     已经挂断
     */
    CallHangup = 5,
};


#endif /* Chat_h */

