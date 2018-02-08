//
//  NRConst.m
//  NewsReport
//
//  Created by Facebook on 2018/1/30.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 消息接收通知 */
NSString * const NRIMMessageReceiveConfigurationNotificationCenterKey = @"com.newsReport.NRIMMessageReceiveConfigurationNotificationCenterKey";

/* 用户登录通知 */
NSString * const NRIMMessageLoginStatusConfigurationNotificationCenterKey =@"com.newsReport.NRIMMessageLoginStatusConfigurationNotificationCenterKey";

/* 连接状态通知（登录成功后）*/
NSString * const NRIMMessageLinkStatusConfigurationNotificationCenterKey = @"com.newsReport.NRIMMessageLinkStatusConfigurationNotificationCenterKey";

/* 删除本地存储消息 */
NSString * const NRIMMessageChatResetConfigurationNotificationCenterKey = @"com.newsReport.NRIMMessageChatResetConfigurationNotificationCenterKey";

/*  接收方 */
NSString *const NRMessageCellIdentifierRecvText     = @"NRMessageCellRecvText";
NSString *const NRMessageCellIdentifierRecvLocation = @"NRMessageCellRecvLocation";
NSString *const NRMessageCellIdentifierRecvVoice    = @"NRMessageCellRecvVoice";
NSString *const NRMessageCellIdentifierRecvVideo    = @"NRMessageCellRecvVideo";
NSString *const NRMessageCellIdentifierRecvImage    = @"NRMessageCellRecvImage";
NSString *const NRMessageCellIdentifierRecvFile     = @"NRMessageCellRecvFile";

/*  发送方 */
NSString *const NRMessageCellIdentifierSendText     = @"NRMessageCellSendText";
NSString *const NRMessageCellIdentifierSendLocation = @"NRMessageCellSendLocation";
NSString *const NRMessageCellIdentifierSendVoice    = @"NRMessageCellSendVoice";
NSString *const NRMessageCellIdentifierSendVideo    = @"NRMessageCellSendVideo";
NSString *const NRMessageCellIdentifierSendImage    = @"NRMessageCellSendImage";
NSString *const NRMessageCellIdentifierSendFile     = @"NRMessageCellSendFile";



