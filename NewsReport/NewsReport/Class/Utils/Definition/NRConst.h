//
//  NRConst.h
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef NRConst_h
#define NRConst_h
#import <UIKit/UIKit.h>


//头像
#define HeadImageHeight 40
#define HeadImageWidth 40

//昵称
#define NameLabelHeight 20
#define NameLabelWidth 200

//图片
#define ImageContentViewMinWidth 120
#define ImageContentViewMaxHeight 180

#define ImageContentViewMaxWidth 180
#define ImageContentViewMinHeight 120

#define ImageContentViewFailWidth 80
#define ImageContentViewFailHeight 60

//视频
#define VideoContentViewMinWidth 120
#define VideoContentViewMaxHeight 150

#define VideoContentViewMaxWidth 150
#define VideoContentViewMinHeight 120

//位置
#define LocationContentViewWidth 150
#define LocationContentViewHeight 150

//文件
#define FileContentViewWidth 200
#define FileContentViewHeight 60

//语音
#define VoiceContentViewWidth 100
#define VoiceContentViewHeight 50

//文字
#define TextContentViewMaxWidth 200

//分享
#define ShareContentViewWidth 230
#define ShareContentViewHeight 125

//红包
#define RedMoneyContentViewWidth 220
#define RedMoneyContentViewHeight 100

#endif /* NRConst_h */

/* 消息接收通知 */
extern NSString * const NRIMMessageReceiveConfigurationNotificationCenterKey;

/* 用户登录通知 */
extern NSString * const NRIMMessageLoginStatusConfigurationNotificationCenterKey;

/* 连接状态通知 */
extern NSString * const NRIMMessageLinkStatusConfigurationNotificationCenterKey;












/*  接收方 */
extern NSString *const NRMessageCellIdentifierRecvText;
extern NSString *const NRMessageCellIdentifierRecvLocation;
extern NSString *const NRMessageCellIdentifierRecvVoice;
extern NSString *const NRMessageCellIdentifierRecvVideo;
extern NSString *const NRMessageCellIdentifierRecvImage;
extern NSString *const DJHMessageCellIdentifierRecvFile;
extern NSString *const DJHMessageCellIdentifierRecvShare;
extern NSString *const DJHMessageCellIdentifierRecvRedMoney;

/*  发送方 */
extern NSString *const DJHMessageCellIdentifierSendText;
extern NSString *const DJHMessageCellIdentifierSendLocation;
extern NSString *const DJHMessageCellIdentifierSendVoice;
extern NSString *const DJHMessageCellIdentifierSendVideo;
extern NSString *const DJHMessageCellIdentifierSendImage;
extern NSString *const DJHMessageCellIdentifierSendFile;
extern NSString *const DJHMessageCellIdentifierSendShare;
extern NSString *const DJHMessageCellIdentifierSendRedMoney;



